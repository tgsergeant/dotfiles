import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import System.IO


myWorkspaces = ["1: Term", "2: Web", "3: Code", "4: Media"] ++ map show [5..8] ++ ["9: VPS"]

xmobarGreen = "#b5bd68"
currentWorkspaceColor = "#81a2be"


myKeys = [ ((controlMask, xK_Print),    spawn "sleep 0.2; scrot -e 'python ~/bin/screenshot.py $f' -s")
        , ((0, xK_Print),               spawn "scrot -e 'python ~/bin/screenshot.py $f'")
        , ((0, 0x1008FF11),             spawn "amixer -c 1 set Master 2-")
        , ((0, 0x1008FF13),             spawn "amixer -c 1 set Master 2+")
        , ((0, 0x1008FF12),             spawn "amixer -D pulse set Master 1+ toggle")
        , ((0, 0x1008FF14),             spawn "mpc toggle")
        , ((0, 0x1008FF15),             spawn "mpc stop")
        , ((0, 0x1008FF16),             spawn "mpc prev")
        , ((0, 0x1008FF17),             spawn "mpc next")
        ]


myManageHook = composeAll [ className =? "Xsane" --> doFloat
                          , className =? "BillOrganiser" --> doFloat
                          ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { terminal = "urxvt"
        , modMask = mod4Mask
        , borderWidth = 1
        , normalBorderColor = "#1d1f21"
        , focusedBorderColor = "#c5c8c6"
        , startupHook = setWMName "LG3D"
        , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor xmobarGreen "" . shorten 100
                    , ppCurrent = xmobarColor currentWorkspaceColor ""
                    }
        , workspaces = myWorkspaces
        } `additionalKeys` myKeys
