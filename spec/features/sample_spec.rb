require "rails_helper"

describe "/tasks" do
  let(:user) { User.create(email: "alice@example.com", password: "password") }
  context "when user logged in" do
    context "when task is not started" do
      let(:not_started_task) { user.tasks.create(content: "Example Task") }
      it "moves task to in progress with AJAX", js: true, points: 3 do
        not_started_task
        sign_in user
        visit "/"
        not_yet_started_section = find("#not_yet_started_list")
        expect(not_yet_started_section.text).to include(not_started_task.content)
        within "#task_#{not_started_task.id}" do
          click_on "Move task"
        end
        not_yet_started_section = find("#not_yet_started_list")
        in_progress_section = find("#in_progress_list")
        expect(in_progress_section.text).to include(not_started_task.content)
      end
    end
  end
end
