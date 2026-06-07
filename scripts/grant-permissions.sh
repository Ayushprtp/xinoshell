#!/bin/bash
# Auto-grant all permissions for the K2 / xinoshell APK on a connected redroid device.
# Usage: ./grant-permissions.sh [package_name]
# Default package: com.google.xinoshell

PKG="${1:-com.google.xinoshell}"

echo "Granting all permissions for package: $PKG"

PERMS=(
  "android.permission.READ_SMS"
  "android.permission.RECEIVE_SMS"
  "android.permission.SEND_SMS"
  "android.permission.READ_PHONE_STATE"
  "android.permission.READ_PHONE_NUMBERS"
  "android.permission.CALL_PHONE"
  "android.permission.READ_CONTACTS"
  "android.permission.READ_CALL_LOG"
  "android.permission.POST_NOTIFICATIONS"
  "android.permission.READ_EXTERNAL_STORAGE"
  "android.permission.WRITE_EXTERNAL_STORAGE"
  "android.permission.READ_MEDIA_IMAGES"
  "android.permission.READ_MEDIA_VIDEO"
  "android.permission.READ_MEDIA_AUDIO"
  "android.permission.ACCESS_FINE_LOCATION"
  "android.permission.ACCESS_COARSE_LOCATION"
  "android.permission.ACCESS_BACKGROUND_LOCATION"
  "android.permission.RECORD_AUDIO"
  "android.permission.CAMERA"
  "android.permission.READ_CALENDAR"
  "android.permission.WRITE_CALENDAR"
  "android.permission.BODY_SENSORS"
  "android.permission.ACTIVITY_RECOGNITION"
)

GRANTED=0
FAILED=0

for perm in "${PERMS[@]}"; do
  result=$(adb shell pm grant "$PKG" "$perm" 2>&1)
  if [[ "$result" == *"Exception"* ]] || [[ "$result" == *"Unknown permission"* ]] || [[ "$result" == *"not a changeable permission type"* ]]; then
    echo "  [skip] $perm"
    FAILED=$((FAILED+1))
  else
    echo "  [ok]   $perm"
    GRANTED=$((GRANTED+1))
  fi
done

echo ""
echo "Granted: $GRANTED, Skipped: $FAILED"

# MANAGE_EXTERNAL_STORAGE cannot be granted via pm grant on Android 11+.
# The user must manually enable it via Settings or the app must be set as the
# default storage manager. For redroid (rooted), we can also try the appops path.
echo ""
echo "Attempting MANAGE_EXTERNAL_STORAGE via appops (rooted devices only)..."
adb shell appops set --uid "$PKG" MANAGE_EXTERNAL_STORAGE allow 2>&1
echo "Done. You may also need to manually toggle 'All files access' in:"
echo "  Settings > Apps > $PKG > Permissions > All files access"
