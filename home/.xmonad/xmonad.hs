import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import System.IO


myWorkspaces = ["1: Term", "2: Web", "3: Code", "4: Media"] ++ map show [5..8] ++ ["9: VPS"]

xmobarGreen = "#8AE234"
currentWorkspaceColor = "#729fcf"


myKeys = [ ((controlMask, xK_Print),    spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print),               spawn "scrot")
        , ((0, 0x1008FF11),             spawn "amixer set Master 2-")
        , ((0, 0x1008FF13),             spawn "amixer set Master 2+")
        , ((0, 0x1008FF12),             spawn "amixer set Master toggle")
        , ((0, 0x1008FF14),             spawn "mpc toggle")
        , ((0, 0x1008FF15),             spawn "mpc stop")
        , ((0, 0x1008FF16),             spawn "mpc prev")
        , ((0, 0x1008FF17),             spawn "mpc next")
        ]


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { terminal = "urxvt"
        , modMask = mod4Mask
        , borderWidth = 1
        , normalBorderColor = "#222222"
        , focusedBorderColor = "#cccccc"
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor xmobarGreen "" . shorten 100
                    , ppCurrent = xmobarColor currentWorkspaceColor ""
                    }
        , workspaces = myWorkspaces
        } `additionalKeys` myKeys
