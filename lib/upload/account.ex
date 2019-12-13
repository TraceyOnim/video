defmodule Upload.Account do
  @moduledoc """
  User account module 
  """
  alias Upload.User

  @doc """
  creates a list of 5 users

    ##Example
     iex(2)> Upload.Account.list_users(%User{})
            [
              %Upload.User{id: 5, name: "name5", username: "user5"},
              %Upload.User{id: 4, name: "name4", username: "user4"},
              %Upload.User{id: 3, name: "name3", username: "user3"},
              %Upload.User{id: 2, name: "name2", username: "user2"},
              %Upload.User{id: 1, name: "name1", username: "user1"}
            ]
  """

  def list_users(user) do
    1..5
    |> Enum.reduce([], fn x, acc ->
      [%{user | id: x, name: "name#{x}", username: "user#{x}"} | acc]
    end)
    |> Enum.reverse()
  end

  @doc """
  get user by id, returns a struct or nil
  """
  def get_user(id) do
    %User{}
    |> list_users()
    |> Enum.find(fn user -> user.id == id end)
  end

  @doc """
  get user by param
  """
  def get_by_param(param, users) do
    param
    |> search(users)
  end

  defp search(%{name: name}, users) do
    Enum.find(list_users(users), fn user -> user.name == name end)
  end

  defp search(%{id: id}, users) do
    Enum.find(list_users(users), fn user -> user.id == id end)
  end

  defp search(%{username: username}, users) do
    Enum.find(list_users(users), fn user -> user.username == username end)
  end
end
