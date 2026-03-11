{ lib, config, ... }:
let
  inherit (config.website) metadata;
  inherit (config.website.layouts) partials;

  inherit (lib.tags)
    html
    head
    body
    div
    footer
    h1
    h3
    p
    a
    meta
    script
    title
    link
    img
    br
    ;
  inherit (lib)
    attrs
    mkAttr
    ;
  titleTag = title;
in
{
  config = {
    website.layouts = {
      base =
        { content, title, ... }:
        let
          pageTitle = if title != null then "${title} - ${metadata.title}" else metadata.title;
        in
        "<!DOCTYPE html>\n"
        + (html
          [ (attrs.lang metadata.lang) ]
          [
            (head
              [ ]
              [
                (meta [ (attrs.charset "UTF-8") ])
                (meta [
                  (attrs.name "viewport")
                  (attrs.content "width=device-width, initial-scale=1.0")
                ])
                (titleTag pageTitle)
                (link [
                  (attrs.rel "icon")
                  (attrs.href "https://www.nix.ru/favicon.svg")
                  (attrs.type "image/svg+xml")
                ])
                (link [
                  (attrs.rel "stylesheet")
                  (attrs.href "/css/style.css")
                ])
                (script [ (attrs.src "/js/counter.js") (mkAttr "defer" "") ] [ ])
                (script [ (attrs.src "/js/anime.js") (mkAttr "defer" "") ] [ ])
              ]
            )
            (body
              [ ]
              [
                (h1 [ ] [ metadata.title ])
                (div [ (attrs.class "container") ] [ content ])
                (footer
                  [ ]
                  [
                    (p
                      [ ]
                      [
                        "Derived and built with"
                        (a
                          [
                            (attrs.href "https://github.com/arnarg/nixtml")
                            (mkAttr "style" "display: inline-block;")
                          ]
                          [ "nixtml" ]
                        )
                        "at"
                        (a [ (attrs.href "https://github.com/barsikus007/nix-victory") ] [ "GitHub" ])
                      ]
                    )
                  ]
                )
              ]
            )
          ]
        );

      home =
        { ... }:
        [
          (div [ (attrs.class "status") ] [ "❄️ПРЕДОПРЕДЕЛЕНА❄️" ])
          (br [ ])
          (partials.reasons {
            reasonsList = [
              [ "❄️ НИКС это ❓" ]
              [ "🔬 предметно-специфический ✅" ]
              [ "💦 чисто функциональный λ" ]
              [ "💤 лениво оцениваемый 💯" ]
              [ "🔈 динамически типизированный 🗃️" ]
              [ "👅 язык программирования 👩‍💻" ]
              [
                (a [ (attrs.href "https://www.nix.ru") ] [ "💻 Компьютерный Супермаркет 🛒" ])
              ]
            ];
          })
          (partials.counter { })
          (h3 [ ] [ "NixOS — объявлено размножение отклонений!" ])
          (partials.memes {
            memesList = [
              "/images/nixos_furry.gif"
              "/images/durka_ebat.gif"
              "/images/chart.jpg"
              "/images/nixiki.jpg"
              "/images/docker.jpg"
              "/images/zfs-linux-crop.png"
              "/images/friend.jpg"
              "/images/path.jpg"
              "/images/chad.jpg"
            ];
          })
          (div
            [ (attrs.class "yandex-mirror") ]
            [
              (a
                [ (attrs.href "https://mirror.yandex.ru/nixos") ]
                [
                  (img [
                    (attrs.src "https://raw.githubusercontent.com/vasiliyaltunin/ru.mirror.yandex/eeb922eb1966b84f4cde28c09b8a1a7efe4eb35b/src/yandex-logo-mirror.svg")
                    (attrs.alt "Yandex Mirror")
                    (mkAttr "style" "height: 150px;")
                  ])
                ]
              )
            ]
          )
          (partials.animeButton { })
        ];

      page =
        { content, ... }:
        [
          content
        ];
      partials = import ./partials.nix { inherit lib; };
    };
  };
}
