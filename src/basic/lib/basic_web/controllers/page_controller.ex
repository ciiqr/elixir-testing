defmodule BasicWeb.PageController do
  use BasicWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
