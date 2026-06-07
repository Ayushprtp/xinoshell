.class public Lcom/google/xinoshell/receivers/NetworkChangeReceiver;
.super Landroid/content/BroadcastReceiver;
.source "NetworkChangeReceiver.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "NetworkChangeReceiver"

.field private static networkChangeListener:Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method public static setNetworkChangeListener(Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;)V
    .locals 0
    .param p0, "listener"    # Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;

    .line 24
    sput-object p0, Lcom/google/xinoshell/receivers/NetworkChangeReceiver;->networkChangeListener:Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;

    .line 25
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 31
    :try_start_0
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 32
    const-string v0, "connectivity"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 33
    .local v0, "cm":Landroid/net/ConnectivityManager;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 34
    .local v1, "activeNetwork":Landroid/net/NetworkInfo;
    :goto_0
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->isConnectedOrConnecting()Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 v2, 0x1

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    .line 36
    .local v2, "isConnected":Z
    :goto_1
    sget-object v3, Lcom/google/xinoshell/receivers/NetworkChangeReceiver;->networkChangeListener:Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;

    if-eqz v3, :cond_3

    .line 37
    if-eqz v2, :cond_2

    .line 38
    sget-object v3, Lcom/google/xinoshell/receivers/NetworkChangeReceiver;->networkChangeListener:Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;

    invoke-interface {v3}, Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;->onNetworkAvailable()V

    goto :goto_2

    .line 40
    :cond_2
    sget-object v3, Lcom/google/xinoshell/receivers/NetworkChangeReceiver;->networkChangeListener:Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;

    invoke-interface {v3}, Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;->onNetworkLost()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 46
    .end local v0    # "cm":Landroid/net/ConnectivityManager;
    .end local v1    # "activeNetwork":Landroid/net/NetworkInfo;
    .end local v2    # "isConnected":Z
    :cond_3
    :goto_2
    nop

    .line 49
    nop

    .line 50
    :try_start_1
    const-class v0, Lcom/google/xinoshell/services/BgService;

    invoke-static {p1, v0}, Lcom/google/xinoshell/utils/ServiceUtil;->isServiceRunning(Landroid/content/Context;Ljava/lang/Class;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 51
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/google/xinoshell/services/BgService;

    invoke-direct {v0, p1, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 52
    .local v0, "serviceIntent":Landroid/content/Intent;
    invoke-virtual {p1, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 53
    nop

    .line 59
    .end local v0    # "serviceIntent":Landroid/content/Intent;
    :cond_4
    nop

    .line 60
    return-void

    .line 57
    :catch_0
    move-exception v0

    .line 58
    .local v0, "err":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 44
    .end local v0    # "err":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 45
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method
