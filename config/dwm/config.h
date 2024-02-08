/* See LICENSE file for copyright and license details. */

// included patches: gaps, switchtotag

#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
// TODO: use lemonbar instead of dwmblocks(anybar patch)
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10", "Segoe UI Emoji:size=10" };
static const char dmenufont[]       = "monospace:size=10";
// static const char col_gray1[]       = "#222222";
// static const char col_gray2[]       = "#444444";
// static const char col_gray3[]       = "#bbbbbb";
// static const char col_gray4[]       = "#eeeeee";
// static const char col_cyan[]        = "#005577";

// bg_color
static const char bg_color[]       = "#0d0d0d";
static const char col_gray2[]       = "#444444";
// fg_color(text)
static const char fg_color[]       = "#d9d0d0";
// change this?
// main_color
static const char col_gray4[]       = "#eeeeee";
static const char main_color[]        = "#bf2a45";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { fg_color, bg_color, bg_color },
	[SchemeSel]  = { col_gray4, main_color,  main_color  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     switchtotag     isfloating     isterminal  noswallow  monitor */
	{ "Gimp",     NULL,       NULL,       0,            0,              1,             0,          0          -1 },
	{ "st",       NULL,       NULL,       0,            0,              0,             1,          0,         -1 },
	{ "wezterm",  NULL,       NULL,       0,            0,              0,             1,          0,         -1 },
/* xev */
	{ NULL,       NULL,       "Event Tester", 0,        0,              0,             0,          1,         -1 }, 
	{ "discord",  NULL,       NULL,       0,            0,              1,             0,          0,         -1 },
	{ "KeePassXC",NULL,       NULL,       0,            0,              1,             0,          0,         -1 },
	{ "zoom",     NULL,       NULL,       0,            0,              1,             0,         -1,         -1 },
	{ "firefox",  NULL,       NULL,       1 << 1,       1,              0,             0,         -1,         -1 },
	// NOTE: picture in picture is added to all tags
	// TODO: set the window position to bottom right
	{ "firefox",  "Toolkit",  "Picture-in-Picture", ~0,  0,              1,             0,         -1,         -1 },
	{ "Google-chrome",  NULL, NULL,       1 << 1,       1,              0,             0,         -1,         -1 },
	{ "Element",  NULL,       NULL,       1 << 2,       1,              1,             0,          0,         -1 },
	{ "obsidian",  NULL,      NULL,       1 << 3,       1,              1,             0,          0,         -1 },
	{ "steam",    NULL,       NULL,       1 << 4,       1,              1,             0,          0,         -1 },
	{ "Lutris",    NULL,       NULL,      1 << 4,       1,              1,             0,          0,         -1 },
	{ "Spotify",  NULL,       NULL,       1 << 8,       1,              0,             0,          0,         -1 },
	{ "nuclear",  NULL,       NULL,       1 << 8,       1,              0,             0,          0,         -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define MODKEY2 Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "application-launcher", NULL };
static const char *termcmd[]  = { "wezterm", NULL };
static const char *lockcmd[]  = { "betterlockscreen", "--lock", NULL };
// FIXME: figure out c naming scheme
static const char *screenshot_full_cmd[]  = { "screenshot", "full", NULL };
static const char *screenshot_select_cmd[]  = { "screenshot", "selection", NULL };
static const char *emoji_picker_cmd[]  = { "emoji-picker", NULL };
static const char *volume_up_cmd[]  = { "volumewizard", "up", NULL };
static const char *volume_down_cmd[]  = { "volumewizard", "down", NULL };
static const char *volume_mute_cmd[]  = { "volumewizard", "mute", NULL };
static const char *media_play_cmd[] = {"playerctl", "play-pause", NULL};
static const char *media_next_cmd[] = {"playerctl", "next", NULL};
static const char *media_prev_cmd[] = {"playerctl", "previous", NULL};
static const char *brightness_up_cmd[] = {"brightnessctl", "set", "+15%", NULL};
static const char *brightness_down_cmd[] = {"brightnessctl", "set", "-15%", NULL};
static const char *mic_mute_cmd[] = {"pactl", "set-source-mute", "toggle", NULL};


static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY2,                      XK_space,  spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY2,                      XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	// { MODKEY,                       XK_Left,  focusmon,       {.i = -1 } },
	// { MODKEY,                       XK_Right, focusmon,       {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_Left,  tagmon,         {.i = -1 } },
	// { MODKEY|ShiftMask,             XK_Right, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_Down,   moveresize,     {.v = "0x 25y 0w 0h" } },
	{ MODKEY,                       XK_Up,     moveresize,     {.v = "0x -25y 0w 0h" } },
	{ MODKEY,                       XK_Right,  moveresize,     {.v = "25x 0y 0w 0h" } },
	{ MODKEY,                       XK_Left,   moveresize,     {.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ShiftMask,             XK_Down,   moveresize,     {.v = "0x 0y 0w 25h" } },
	{ MODKEY|ShiftMask,             XK_Up,     moveresize,     {.v = "0x 0y 0w -25h" } },
	{ MODKEY|ShiftMask,             XK_Right,  moveresize,     {.v = "0x 0y 25w 0h" } },
	{ MODKEY|ShiftMask,             XK_Left,   moveresize,     {.v = "0x 0y -25w 0h" } },
	{ MODKEY|ControlMask,           XK_Up,     moveresizeedge, {.v = "t"} },
	{ MODKEY|ControlMask,           XK_Down,   moveresizeedge, {.v = "b"} },
	{ MODKEY|ControlMask,           XK_Left,   moveresizeedge, {.v = "l"} },
	{ MODKEY|ControlMask,           XK_Right,  moveresizeedge, {.v = "r"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Up,     moveresizeedge, {.v = "T"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Down,   moveresizeedge, {.v = "B"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Left,   moveresizeedge, {.v = "L"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Right,  moveresizeedge, {.v = "R"} },
	// my own keybinds
	// lock
	{ MODKEY|ShiftMask,             XK_x,      spawn,          {.v = lockcmd } },
	// screenshot
	{ ShiftMask,                    0xff61,    spawn,          {.v = screenshot_full_cmd } },
	{ 0,                            0xff61,    spawn,          {.v = screenshot_select_cmd } },
	// volume
	{ 0,                            XF86XK_AudioRaiseVolume, spawn,          {.v = volume_up_cmd } },
	{ 0,                            XF86XK_AudioLowerVolume, spawn,          {.v = volume_down_cmd } },
	{ 0,                            XF86XK_AudioMute, spawn,          {.v = volume_mute_cmd } },
	// media control
	{ 0,                            XF86XK_AudioPlay, spawn,          {.v = media_play_cmd } },
	{ 0,                            XF86XK_AudioNext, spawn,          {.v = media_next_cmd } },
	{ 0,                            XF86XK_AudioPrev, spawn,          {.v = media_prev_cmd } },
	// brightness
	{ 0,                            XF86XK_MonBrightnessUp, spawn,         {.v = brightness_up_cmd } },
	{ 0,                            XF86XK_MonBrightnessDown, spawn,         {.v =  brightness_down_cmd } },
	// mute mic
	{ 0,                            XF86XK_AudioMicMute, spawn,         {.v = mic_mute_cmd } },
	{ MODKEY,                       XK_period, spawn,       {.v = emoji_picker_cmd } },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

