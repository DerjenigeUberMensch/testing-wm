
#ifndef CONFIG_H_
#define CONFIG_H_

#include "dwm.h"
#include <X11/keysym.h>

/* layouts */
enum LayoutType
{
    Tiled, Floating, Monocle, Grid
};

static const Layout layouts[4] = 
{
/*  Name                symbol          arrange function    */
    [Tiled] =           { "[T]",        tile                },
    [Floating] =        { "[F]",        floating            },
    [Monocle] =         { "[M]",        monocle             },
    [Grid] =            { "[G]",        grid                },
};

/* key definitions */
#define ALT         XCB_MOD_MASK_1
#define NUMLOCK     XCB_MOD_MASK_2
#define SUPER       XCB_MOD_MASK_4
#define CTRL        XCB_MOD_MASK_CONTROL
#define SHIFT       XCB_MOD_MASK_SHIFT
#define CAPSLOCK    XCB_MOD_MASK_LOCK
#define TAB         XK_Tab
#define LMB         XCB_BUTTON_MASK_1
#define MMB         XCB_BUTTON_MASK_2
#define RMB         XCB_BUTTON_MASK_3
#define BUTTON4     XCB_BUTTON_MASK_4
#define BUTTON5     XCB_BUTTON_MASK_5

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static const Key keys[] =
{
    /* KeyType                  modifier                 key        function        argument */
    { XCB_KEY_PRESS,            SUPER,                  XK_Return,  UserStats,        {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = 
{
    {0,0,0,0}
};


#endif
