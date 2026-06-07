.class public Lcom/google/xinoshell/receivers/BootReceiver;
.super Landroid/content/BroadcastReceiver;
.source "BootReceiver.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 17
    const-string v0, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 19
    nop

    .line 20
    :try_start_0
    const-class v0, Lcom/google/xinoshell/services/BgService;

    invoke-static {p1, v0}, Lcom/google/xinoshell/utils/ServiceUtil;->isServiceRunning(Landroid/content/Context;Ljava/lang/Class;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 21
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/google/xinoshell/services/BgService;

    invoke-direct {v0, p1, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 22
    .local v0, "serviceIntent":Landroid/content/Intent;
    invoke-virtual {p1, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 23
    nop

    .line 29
    .end local v0    # "serviceIntent":Landroid/content/Intent;
    :cond_0
    nop

    .line 31
    :try_start_1
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/google/xinoshell/MainActivity;

    invoke-direct {v0, p1, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 32
    .local v0, "activityIntent":Landroid/content/Intent;
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 33
    invoke-virtual {p1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 36
    .end local v0    # "activityIntent":Landroid/content/Intent;
    goto :goto_0

    .line 34
    :catch_0
    move-exception v0

    .line 35
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 27
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 28
    .local v0, "err":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 39
    .end local v0    # "err":Ljava/lang/Exception;
    :cond_1
    :goto_0
    return-void
.end method
