defmodule DevJobsWeb.UserProfileLive do
  use DevJobsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
