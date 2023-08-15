defmodule PicChat.Repo.Migrations.AddPictureToMessage do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :picture, :text
    end
  end
end
