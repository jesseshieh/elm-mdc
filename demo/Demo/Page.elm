module Demo.Page exposing
    ( Page
    , demos
    , header
    , hero
    , subheader
    , toolbar
    )

import Demo.Url as Url exposing (Url)
import Html exposing (Html, div, h2, text)
import Html.Attributes as Html
import Material
import Material.Icon as Icon
import Material.Options as Options exposing (Property, cs, css, styled)
import Material.TopAppBar as TopAppBar
import Material.Typography as Typography


type alias Page m =
    { toolbar : String -> Html m
    , navigate : Url -> m
    , body : String -> String -> List (Html m) -> Html m
    }


toolbar :
    (Material.Msg m -> m)
    -> Material.Index
    -> Material.Model m
    -> (Url -> m)
    -> Url
    -> String
    -> Html m
toolbar lift idx mdc navigate url title =
    TopAppBar.view lift
        idx
        mdc
        [ cs "catalog-top-app-bar"
        ]
        [ TopAppBar.section
            [ TopAppBar.alignStart
            ]
            [ styled Html.div
                [ cs "catalog-back"
                , css "padding-right" "24px"
                ]
                [ case url of
                    Url.StartPage ->
                        styled Html.img
                            [ cs "mdc-toolbar__menu-icon"
                            , Options.attribute (Html.src "images/ic_component_24px_white.svg")
                            ]
                            []

                    _ ->
                        Icon.view
                            [ Options.onClick (navigate Url.StartPage)
                            ]
                            "arrow_back"
                ]
            , TopAppBar.title
                [ cs "catalog-top-app-bar__title"
                , css "margin-left"
                    (if url == Url.StartPage then
                        "8px"

                     else
                        "24"
                    )
                ]
                [ text title ]
            ]
        ]


header : String -> Html m
header title =
    styled Html.h1
        [ Typography.headline5 ]
        [ text title ]


subheader : String -> Html m
subheader title =
    styled Html.h3
        [ Typography.subtitle1 ]
        [ text title ]


hero : List (Property c m) -> List (Html m) -> Html m
hero options =
    styled Html.section
        (List.reverse
            (cs "hero"
                :: css "display" "-webkit-box"
                :: css "display" "-ms-flexbox"
                :: css "display" "flex"
                :: css "-webkit-box-orient" "horizontal"
                :: css "-webkit-box-direction" "normal"
                :: css "-ms-flex-flow" "row nowrap"
                :: css "flex-flow" "row nowrap"
                :: css "-webkit-box-align" "center"
                :: css "-ms-flex-align" "center"
                :: css "align-items" "center"
                :: css "-webkit-box-pack" "center"
                :: css "-ms-flex-pack" "center"
                :: css "justify-content" "center"
                :: css "height" "360px"
                :: css "min-height" "360px"
                :: css "background-color" "rgba(0, 0, 0, 0.05)"
                :: css "padding" "24px"
                :: options
            )
        )


demos : List (Html m) -> Html m
demos nodes =
    styled div
        [ css "padding-bottom" "20px" ]
        (styled h2
            [ Typography.headline6
            , css "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Demos" ]
            :: nodes
        )
