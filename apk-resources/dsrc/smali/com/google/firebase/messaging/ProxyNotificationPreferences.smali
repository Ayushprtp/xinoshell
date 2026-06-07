.class final Lcom/google/firebase/messaging/ProxyNotificationPreferences;
.super Ljava/lang/Object;
.source "ProxyNotificationPreferences.java"


# static fields
.field private static final FCM_PREFERENCES:Ljava/lang/String; = "com.google.firebase.messaging"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    return-void
.end method

.method private static getPreference(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 39
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 40
    .local v0, "appContext":Landroid/content/Context;
    if-nez v0, :cond_0

    .line 41
    move-object v0, p0

    .line 44
    :cond_0
    const-string v1, "com.google.firebase.messaging"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    return-object v1
.end method

.method static isProxyNotificationInitialized(Landroid/content/Context;)Z
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 71
    invoke-static {p0}, Lcom/google/firebase/messaging/ProxyNotificationPreferences;->getPreference(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "proxy_notification_initialized"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method static isProxyNotificationRetentionSet(Landroid/content/SharedPreferences;Z)Z
    .locals 3
    .param p0, "preferences"    # Landroid/content/SharedPreferences;
    .param p1, "retention"    # Z

    .line 76
    const-string v0, "proxy_retention"

    invoke-interface {p0, v0}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    .line 77
    invoke-interface {p0, v0, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-ne v0, p1, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    nop

    .line 76
    :goto_0
    return v2
.end method

.method static synthetic lambda$setProxyRetention$0(Landroid/content/Context;ZLjava/lang/Void;)V
    .locals 0
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "retention"    # Z
    .param p2, "unused"    # Ljava/lang/Void;

    .line 65
    invoke-static {p0, p1}, Lcom/google/firebase/messaging/ProxyNotificationPreferences;->setProxyRetentionPreferences(Landroid/content/Context;Z)V

    return-void
.end method

.method static setProxyNotificationsInitialized(Landroid/content/Context;Z)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "isInitialized"    # Z

    .line 49
    invoke-static {p0}, Lcom/google/firebase/messaging/ProxyNotificationPreferences;->getPreference(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 50
    .local v0, "preferencesEditor":Landroid/content/SharedPreferences$Editor;
    const-string v1, "proxy_notification_initialized"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 51
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 52
    return-void
.end method

.method static setProxyRetention(Landroid/content/Context;Lcom/google/firebase/messaging/GmsRpc;Z)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "gmsRpc"    # Lcom/google/firebase/messaging/GmsRpc;
    .param p2, "retention"    # Z

    .line 56
    invoke-static {}, Lcom/google/android/gms/common/util/PlatformVersion;->isAtLeastQ()Z

    move-result v0

    if-nez v0, :cond_0

    .line 58
    return-void

    .line 60
    :cond_0
    invoke-static {p0}, Lcom/google/firebase/messaging/ProxyNotificationPreferences;->getPreference(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 61
    .local v0, "preferences":Landroid/content/SharedPreferences;
    invoke-static {v0, p2}, Lcom/google/firebase/messaging/ProxyNotificationPreferences;->isProxyNotificationRetentionSet(Landroid/content/SharedPreferences;Z)Z

    move-result v1

    if-nez v1, :cond_1

    .line 62
    nop

    .line 63
    invoke-virtual {p1, p2}, Lcom/google/firebase/messaging/GmsRpc;->setRetainProxiedNotifications(Z)Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    new-instance v2, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda0;

    invoke-direct {v2}, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda0;-><init>()V

    new-instance v3, Lcom/google/firebase/messaging/ProxyNotificationPreferences$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0, p2}, Lcom/google/firebase/messaging/ProxyNotificationPreferences$$ExternalSyntheticLambda0;-><init>(Landroid/content/Context;Z)V

    .line 64
    invoke-virtual {v1, v2, v3}, Lcom/google/android/gms/tasks/Task;->addOnSuccessListener(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/OnSuccessListener;)Lcom/google/android/gms/tasks/Task;

    .line 67
    :cond_1
    return-void
.end method

.method static setProxyRetentionPreferences(Landroid/content/Context;Z)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "retention"    # Z

    .line 82
    invoke-static {p0}, Lcom/google/firebase/messaging/ProxyNotificationPreferences;->getPreference(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 83
    .local v0, "preferencesEditor":Landroid/content/SharedPreferences$Editor;
    const-string v1, "proxy_retention"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 84
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 85
    return-void
.end method
