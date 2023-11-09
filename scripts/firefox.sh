#!/bin/bash

# install betterfox's fastfox and smoothfox user.js and merge it into one file
curl -o user.js https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js

# append smooth scroll settings and betterfox overrides to user.js
echo "


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
" >> user.js

# ensure profiles directory is created
if [ ! -d ~/.mozilla/ ]; then
    sleep 5 && killall firefox &
    firefox -headless &
    wait
fi
# move user.js to default firefox profile
mv user.js "$(find ~/.mozilla/firefox/ -type d -name "*.default-release")"

