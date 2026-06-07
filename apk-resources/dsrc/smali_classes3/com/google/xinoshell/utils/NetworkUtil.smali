.class public Lcom/google/xinoshell/utils/NetworkUtil;
.super Ljava/lang/Object;
.source "NetworkUtil.java"


# static fields
.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 14
    const-class v0, Lcom/google/xinoshell/utils/NetworkUtil;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getActiveNetworkType(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 96
    :try_start_0
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 97
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v0, :cond_5

    .line 98
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetwork()Landroid/net/Network;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/net/ConnectivityManager;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object v1

    .line 99
    .local v1, "capabilities":Landroid/net/NetworkCapabilities;
    if-eqz v1, :cond_5

    .line 100
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 101
    const-string v2, "WiFi"

    return-object v2

    .line 102
    :cond_0
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 103
    const-string v2, "Mobile"

    return-object v2

    .line 104
    :cond_1
    const/4 v2, 0x3

    invoke-virtual {v1, v2}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 105
    const-string v2, "Ethernet"

    return-object v2

    .line 106
    :cond_2
    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 107
    const-string v2, "Bluetooth"

    return-object v2

    .line 108
    :cond_3
    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 109
    const-string v2, "VPN"

    return-object v2

    .line 111
    :cond_4
    const-string v2, "Unknown"
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 117
    .end local v0    # "connectivityManager":Landroid/net/ConnectivityManager;
    .end local v1    # "capabilities":Landroid/net/NetworkCapabilities;
    :cond_5
    goto :goto_0

    .line 115
    :catch_0
    move-exception v0

    .line 116
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v2, "Error getting active network type"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 118
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    const-string v0, "None"

    return-object v0
.end method

.method public static hasInternetConnectivity()Z
    .locals 4

    .line 165
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "www.google.com"

    invoke-static {v1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v1

    .line 166
    .local v1, "address":Ljava/net/InetAddress;
    if-eqz v1, :cond_0

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/net/InetAddress;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v2, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 167
    .end local v1    # "address":Ljava/net/InetAddress;
    :catch_0
    move-exception v1

    .line 168
    .local v1, "e":Ljava/io/IOException;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking internet connectivity"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 170
    .end local v1    # "e":Ljava/io/IOException;
    return v0
.end method

.method public static isAirplaneModeOn(Landroid/content/Context;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 124
    nop

    .line 128
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "airplane_mode_on"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 129
    :catch_0
    move-exception v1

    .line 130
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking airplane mode"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 132
    .end local v1    # "e":Ljava/lang/Exception;
    return v0
.end method

.method public static isBluetoothConnected(Landroid/content/Context;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 68
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "connectivity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    .line 69
    .local v1, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v1, :cond_1

    .line 70
    const/4 v2, 0x7

    invoke-virtual {v1, v2}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v2

    .line 71
    .local v2, "bluetoothInfo":Landroid/net/NetworkInfo;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 75
    .end local v1    # "connectivityManager":Landroid/net/ConnectivityManager;
    .end local v2    # "bluetoothInfo":Landroid/net/NetworkInfo;
    :cond_1
    goto :goto_0

    .line 73
    :catch_0
    move-exception v1

    .line 74
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking Bluetooth connection"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 76
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return v0
.end method

.method public static isMobileDataConnected(Landroid/content/Context;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 54
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "connectivity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    .line 55
    .local v1, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v1, :cond_1

    .line 56
    invoke-virtual {v1, v0}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v2

    .line 57
    .local v2, "mobileInfo":Landroid/net/NetworkInfo;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 61
    .end local v1    # "connectivityManager":Landroid/net/ConnectivityManager;
    .end local v2    # "mobileInfo":Landroid/net/NetworkInfo;
    :cond_1
    goto :goto_0

    .line 59
    :catch_0
    move-exception v1

    .line 60
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking mobile data connection"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 62
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return v0
.end method

.method public static isNetworkConnected(Landroid/content/Context;)Z
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .line 19
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "connectivity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    .line 20
    .local v1, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v1, :cond_2

    .line 21
    nop

    .line 22
    invoke-virtual {v1}, Landroid/net/ConnectivityManager;->getActiveNetwork()Landroid/net/Network;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/net/ConnectivityManager;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object v2

    .line 23
    .local v2, "capabilities":Landroid/net/NetworkCapabilities;
    if-eqz v2, :cond_1

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v4

    if-nez v4, :cond_0

    .line 24
    invoke-virtual {v2, v0}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v4

    if-nez v4, :cond_0

    .line 25
    const/4 v4, 0x3

    invoke-virtual {v2, v4}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v4, :cond_1

    :cond_0
    move v0, v3

    goto :goto_0

    :cond_1
    nop

    .line 23
    :goto_0
    return v0

    .line 33
    .end local v1    # "connectivityManager":Landroid/net/ConnectivityManager;
    .end local v2    # "capabilities":Landroid/net/NetworkCapabilities;
    :cond_2
    goto :goto_1

    .line 31
    :catch_0
    move-exception v1

    .line 32
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking network connection"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 34
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    return v0
.end method

.method public static isNetworkMetered(Landroid/content/Context;)Z
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 138
    :try_start_0
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 139
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v0, :cond_0

    .line 140
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->isActiveNetworkMetered()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    .line 144
    .end local v0    # "connectivityManager":Landroid/net/ConnectivityManager;
    :cond_0
    goto :goto_0

    .line 142
    :catch_0
    move-exception v0

    .line 143
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v2, "Error checking network metered status"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 145
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public static isNetworkRoaming(Landroid/content/Context;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 151
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "connectivity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    .line 152
    .local v1, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v1, :cond_1

    .line 153
    invoke-virtual {v1}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v2

    .line 154
    .local v2, "activeNetworkInfo":Landroid/net/NetworkInfo;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isRoaming()Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 158
    .end local v1    # "connectivityManager":Landroid/net/ConnectivityManager;
    .end local v2    # "activeNetworkInfo":Landroid/net/NetworkInfo;
    :cond_1
    goto :goto_0

    .line 156
    :catch_0
    move-exception v1

    .line 157
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking network roaming status"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 159
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return v0
.end method

.method public static isVpnConnected(Landroid/content/Context;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 82
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "connectivity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    .line 83
    .local v1, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v1, :cond_1

    .line 84
    invoke-virtual {v1}, Landroid/net/ConnectivityManager;->getActiveNetwork()Landroid/net/Network;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/net/ConnectivityManager;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object v2

    .line 85
    .local v2, "capabilities":Landroid/net/NetworkCapabilities;
    if-eqz v2, :cond_0

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Landroid/net/NetworkCapabilities;->hasTransport(I)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 89
    .end local v1    # "connectivityManager":Landroid/net/ConnectivityManager;
    .end local v2    # "capabilities":Landroid/net/NetworkCapabilities;
    :cond_1
    goto :goto_0

    .line 87
    :catch_0
    move-exception v1

    .line 88
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking VPN connection"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 90
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return v0
.end method

.method public static isWifiConnected(Landroid/content/Context;)Z
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .line 40
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "connectivity"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    .line 41
    .local v1, "connectivityManager":Landroid/net/ConnectivityManager;
    if-eqz v1, :cond_1

    .line 42
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v3

    .line 43
    .local v3, "wifiInfo":Landroid/net/NetworkInfo;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v4, :cond_0

    move v0, v2

    :cond_0
    return v0

    .line 47
    .end local v1    # "connectivityManager":Landroid/net/ConnectivityManager;
    .end local v3    # "wifiInfo":Landroid/net/NetworkInfo;
    :cond_1
    goto :goto_0

    .line 45
    :catch_0
    move-exception v1

    .line 46
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/google/xinoshell/utils/NetworkUtil;->TAG:Ljava/lang/String;

    const-string v3, "Error checking WiFi connection"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 48
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return v0
.end method
