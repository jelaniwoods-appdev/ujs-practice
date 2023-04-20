require "rails_helper"

# describe "This project" do
#   it "has no tests" do
#     expect(1).to eq(1)
#   end
# end

describe "/tasks" do
  let(:user) { User.create(email: "alice@example.com", password: "password") }
  context "when user logged in" do
    context "when task is not started" do
      let(:not_started_task) { user.tasks.create(content: "Example Task") }
      it "moves task to in progress with AJAX", js: true do
        not_started_task
        sign_in user
        # p user.tasks.count
        # p user.tasks.create(content: "Example Task")
        visit "/"
        # p page.text
        # p not_started_task.errors.full_messages
        # p find("#not_yet_started_list").text
        # task_element = find("#task_#{not_started_task.id}")
        not_yet_started_section = find("#not_yet_started_list")
        expect(not_yet_started_section.text).to include(not_started_task.content)
        within "#task_#{not_started_task.id}" do
          click_on "Move task"
        end
        not_yet_started_section = find("#not_yet_started_list")
        in_progress_section = find("#in_progress_list")
        # p not_yet_started_section.text
        # p in_progress_section.text
        expect(in_progress_section.text).to include(not_started_task.content)
        # expect(1).to eq(2)
      end
    end
  end
end
