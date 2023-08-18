defmodule PicChat.Repo.Migrations.AddSubscribedToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :subscribed, :boolean, default: false
    end
  end
end
