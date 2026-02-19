{ lib, ... }:
let
  inherit (lib.tags)
    div
    span
    a
    h2
    ul
    li
    img
    ;
  inherit (lib) attrs;
in
{
  counter =
    { }:
    let
      counterInitial = [
        {
          name = "years";
          nameRu = "лет";
          initial = 22;
        }
        {
          name = "days";
          nameRu = "дней";
          initial = 228;
        }
        {
          name = "hours";
          nameRu = "часов";
          initial = 9;
        }
        {
          name = "minutes";
          nameRu = "минут";
          initial = 42;
        }
        {
          name = "seconds";
          nameRu = "секунд";
          initial = 69;
        }
        {
          name = "milliseconds";
          nameRu = "ms";
          initial = 420;
        }
      ];
    in
    [
      (div [ (attrs.id "victory-counter") ] (
        (map (
          counterSlot:
          div
            [ (attrs.class "counter-item") ]
            [
              (span
                [
                  (attrs.class "number")
                  (attrs.id "counter-item-${counterSlot.name}")
                ]
                [ (toString counterSlot.initial) ]
              )
              (span [ (attrs.class "label") ] [ counterSlot.nameRu ])
            ]
        ) counterInitial)

        ++ [
          (div
            [ (attrs.class "counter-label") ]
            [
              "с "
              (a
                [ (attrs.href "https://github.com/NixOS/nix/commit/75d788b0f24e8de033a22c0869032549d602d4f6") ]
                [ "момента начала" ]
              )
              " победы воспроизводства"
              (a [ (attrs.href "/secret") ] [ "!" ])
            ]
          )
        ]
      ))
    ];
  reasons =
    { reasonsList }:
    [
      (h2
        [ (attrs.class "reasons") ]
        [
          (span [ (attrs.id "reasons-year") ] [ "Почему" ])
          # XSS
          "<script>document.getElementById('reasons-year').appendChild(document.createTextNode(new Date().getFullYear()))</script>"
          "это очередной год никс победы?"
        ]
      )
      (ul [ (attrs.class "reasons") ] (map (reason: li [ ] reason) reasonsList))
    ];
  memes =
    { memesList }:
    [
      (div [ (attrs.class "memes") ] (map (meme: img [ (attrs.src meme) ]) memesList))
    ];
  animeButton =
    { }:
    [
      (img [
        (attrs.src "https://noteblock.studio/images/icon.png")
        (attrs.id "anime-button")
      ])
    ];
}
