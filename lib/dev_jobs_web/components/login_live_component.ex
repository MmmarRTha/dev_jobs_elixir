defmodule DevJobsWeb.LoginLiveComponent do
  use DevJobsWeb, :live_component

  alias DevJobs.Users.User
  alias DevJobs.Users

  def mount(socket) do
    user = %User{}
    changeset = User.changeset(user)
    socket = assign(socket, user: user, changeset: changeset)
    {:ok, socket}
  end

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      socket.assigns.user
      |> User.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Users.save_user(params) do
      {:ok, user} ->
        magic_link_url = &(~p"/users/sessions/#{&1}" |> url())
        Users.deliver_magic_link(user, magic_link_url)

        {:noreply,
         socket
         |> put_flash(
           :info,
           gettext("An email to %{email} has been sent to you to login DevJobs.", %{
             email: user.email
           })
         )
         |> push_navigate(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def render(assigns) do
    ~H"""
    <div>
      <div :if={!@current_user}>
        <.button
          class="uppercase bg-blue-500 hover:bg-blue-600"
          phx-click={show_modal("login-form-modal")}
        >
          login
        </.button>

        <.modal id="login-form-modal">
          <.form
            :let={f}
            for={@changeset}
            phx-change="validate"
            phx-submit="save"
            phx-target={@myself}
            class="space-y-6"
            autocomplete="off"
          >
            <.input type="email" field={f[:email]} label="Email" />
            <.button class="bg-sky-500 hover:bg-sky-600">
              Send Magic Link
            </.button>
          </.form>
        </.modal>
      </div>

      <div :if={@current_user} class="flex items-center leading-6">
        <p class="px-4 font-medium text-white">Welcome: <%= @current_user.email %></p>
        <.link
          href={~p"/users/sessions/logout"}
          method="delete"
          class="px-3 py-3 text-sm font-semibold text-white uppercase bg-blue-500 rounded-lg hover:bg-blue-600"
        >
          Logout
        </.link>
      </div>
    </div>
    """
  end
end
