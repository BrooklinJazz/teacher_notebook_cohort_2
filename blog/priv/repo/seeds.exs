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

Enum.each(1..100, fn index ->
  Blog.Repo.insert!(%Blog.Posts.Post{
    title: "some title #{index}",
    subtitle: "some subtitle #{index}",
    content: "some content #{index}"
  })
end)
