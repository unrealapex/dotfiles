#!/bin/bash

# ensure profiles directory is created
if [ ! -d "~/.mozilla/" ]; then
    sleep 5 && killall firefox &
    firefox -headless &
    wait
fi

profile_path=$(find ~/.mozilla/firefox/ -type d -name "*.default-release")

# fetch betterfox user.js
curl -o user.js https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js

# append smooth scroll settings and betterfox overrides to user.js
echo '


// smooth scroll
user_pref("apz.overscroll.enabled", true); // not DEFAULT on Linux
user_pref("general.smoothScroll", true); // DEFAULT
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", 2.0);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
user_pref("general.smoothScroll.currentVelocityWeighting", 1.0);
user_pref("general.smoothScroll.stopDecelerationWeighting", 1.0);
user_pref("mousewheel.default.delta_multiplier_y", 300); // 250-400; adjust this number to your liking

// overrides
user_pref("browser.newtabpage.activity-stream.feeds.topsites", true);
user_pref("identity.fxaccounts.enabled", true);
user_pref("browser.tabs.firefox-view", true);
user_pref("extensions.pocket.enabled", true);
user_pref("browser.tabs.tabmanager.enabled", true);
user_pref("privacy.userContext.ui.enabled", false);
user_pref("browser.search.suggest.enabled", true);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", true);
user_pref("browser.toolbars.bookmarks.visibility", "always");
user_pref("findbar.highlightAll", true);
user_pref("browser.safebrowsing.downloads.remote.enabled", true);
user_pref("browser.contentblocking.category", "standard");
user_pref("permissions.default.desktop-notification", 0);
user_pref("permissions.default.geo", 0);
user_pref("devtools.toolbox.host", "right");
' >> user.js

# move user.js to default firefox profile
mv user.js "$profile_path"

