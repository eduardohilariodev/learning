"use strict";
chrome.runtime.onInstalled.addListener(() => {
    chrome.action.setBadgeText({ text: "OFF" });
});
const extensions = "https://developer.chrome.com/docs/extensions";
const webstore = "https://developer.chrome.com/docs/webstore";
chrome.action.onClicked.addListener(async (tab) => {
    if (tab.url?.startsWith(extensions) || tab.url?.startsWith(webstore)) {
        const prevState = await chrome.action.getBadgeText({ tabId: tab.id });
        const nextState = prevState === "ON" ? "OFF" : "ON";
        await chrome.action.setBadgeText({ text: nextState, tabId: tab.id });
        if (tab.id) {
            switch (nextState) {
                case "ON":
                    chrome.scripting.insertCSS({
                        files: ["focus-mode.css"],
                        target: { tabId: tab.id },
                    });
                case "OFF":
                    chrome.scripting.removeCSS({
                        files: ["focus-mode.css"],
                        target: { tabId: tab.id },
                    });
            }
        }
    }
});
