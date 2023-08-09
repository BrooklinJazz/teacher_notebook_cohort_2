# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

content = Enum.to_list(1..100) |> Enum.join(" ")
Blog.Repo.insert!(%Blog.Posts.Post{
  title: "long title long title long title long title long title long title long title long title long title long title",
  subtitle: "long subtitle long subtitle long subtitle long subtitle long subtitle long subtitle long subtitle ",
  content: content
})
