// This file sets default preferences for Firefox within the Docker container.

// --- Proxy Settings ---
// Set proxy type to manual (1)
pref("network.proxy.type", 1);
// Set HTTP proxy host and port
pref("network.proxy.http", "172.17.0.4");
pref("network.proxy.http_port", 1337);
// Set SSL/HTTPS proxy host and port (use the same as HTTP for simplicity)
pref("network.proxy.ssl", "172.17.0.4");
pref("network.proxy.ssl_port", 1337);
// Share proxy settings for all protocols (makes it apply to HTTPS, FTP, etc.)
pref("network.proxy.share_proxy_settings", true);
// Do not proxy for localhost and 127.0.0.1 (optional, but generally good practice)
pref("network.proxy.no_proxies_on", "localhost, 127.0.0.1");


// --- SSL/TLS Version Settings (for POODLE attack) ---
// Set minimum TLS/SSL version to SSL 3.0 (value 0)
// This is crucial for POODLE as modern browsers disable SSL 3.0 by default.
pref("security.tls.version.min", 0);
// Set maximum TLS/SSL version to TLS 1.0 (value 1)
// This ensures it doesn't try to negotiate higher, more secure TLS versions.
pref("security.tls.version.max", 1);

// --- Enable DES-CBC3-SHA for SSLv3 ---
// This explicitly allows the DES-CBC3-SHA cipher suite for SSLv3 connections.
pref("security.ssl3.dhe_rsa_des_ede3_sha", true);

// --- Optional: Disable Firefox updates (highly recommended for a fixed lab environment) ---
// Prevents Firefox from trying to update itself to a newer version that might break SSL 3.0 support
pref("app.update.enabled", false);
pref("app.update.autoInstallEnabled", false);
pref("app.update.mode", 0); // 0 = never check for updates
