require "rails_helper"

describe "/tasks" do
  let(:user) { User.create(email: "alice@example.com", password: "password") }
  context "when user logged in" do
    context "when task is not started" do
      let(:not_started_task) { user.tasks.create(content: "Example Task") }
      before(:example) do 
        # load task
        not_started_task
        sign_in user
        visit "/"
      end
      it "has a link with the attribute data-remote=\"true\"", js: true, points: 1 do
        not_yet_started_section = find("#not_yet_started_list")
        expect(not_yet_started_section.text).to include(not_started_task.content)
        within "#task_#{not_started_task.id}" do
          first_link = all("a")[0]
          expect(first_link["data-remote"]).to eq "true"
        end
      end

      it "has a link with the attribute data-method=\"patch\"", js: true, points: 1 do
        not_yet_started_section = find("#not_yet_started_list")
        expect(not_yet_started_section.text).to include(not_started_task.content)
        within "#task_#{not_started_task.id}" do
          first_link = all("a")[0]
          expect(first_link["data-method"]).to eq "patch"
        end
      end

      it "has a link that moves a task to #in_progress_list with a PATCH AJAX", js: true, points: 3 do
        not_yet_started_section = find("#not_yet_started_list")
        expect(not_yet_started_section.text).to include(not_started_task.content)
        within "#task_#{not_started_task.id}" do
          first_link = all("a")[0]
          expect(first_link["data-method"]).to eq "patch"
          first_link.click
        end
        not_yet_started_section = find("#not_yet_started_list")
        in_progress_section = find("#in_progress_list")
        expect(in_progress_section.text).to include(not_started_task.content)
      end
    end
  end
end
