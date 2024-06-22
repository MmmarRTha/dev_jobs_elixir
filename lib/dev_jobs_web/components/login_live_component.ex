defmodule DevJobsWeb.LoginLiveComponent do
    use DevJobsWeb, :live_component

    def render(assigns) do
      ~H"""
      <div>
      <.modal id="login-form-modal">
        <div>
          Login Modal
        </div>
      </.modal>
      </div>
      """
    end
  end
