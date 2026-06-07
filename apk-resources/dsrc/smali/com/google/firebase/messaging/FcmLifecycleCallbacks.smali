.class Lcom/google/firebase/messaging/FcmLifecycleCallbacks;
.super Ljava/lang/Object;
.source "FcmLifecycleCallbacks.java"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;


# static fields
.field private static final RECENTLY_LOGGED_MESSAGE_IDS_MAX_SIZE:I = 0xa


# instance fields
.field private final recentlyLoggedMessageIds:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 2

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    new-instance v0, Ljava/util/ArrayDeque;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Ljava/util/ArrayDeque;-><init>(I)V

    iput-object v0, p0, Lcom/google/firebase/messaging/FcmLifecycleCallbacks;->recentlyLoggedMessageIds:Ljava/util/Queue;

    return-void
.end method

.method private logNotificationOpen(Landroid/content/Intent;)V
    .locals 4
    .param p1, "startingIntent"    # Landroid/content/Intent;

    .line 79
    const/4 v0, 0x0

    .line 81
    .local v0, "analyticsData":Landroid/os/Bundle;
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    .line 82
    .local v1, "extras":Landroid/os/Bundle;
    if-eqz v1, :cond_2

    .line 83
    invoke-static {v1}, Lcom/google/firebase/messaging/MessagingAnalytics;->getMessageId(Landroid/os/Bundle;)Ljava/lang/String;

    move-result-object v2

    .line 84
    .local v2, "messageId":Ljava/lang/String;
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 85
    iget-object v3, p0, Lcom/google/firebase/messaging/FcmLifecycleCallbacks;->recentlyLoggedMessageIds:Ljava/util/Queue;

    invoke-interface {v3, v2}, Ljava/util/Queue;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 87
    return-void

    .line 89
    :cond_0
    iget-object v3, p0, Lcom/google/firebase/messaging/FcmLifecycleCallbacks;->recentlyLoggedMessageIds:Ljava/util/Queue;

    invoke-interface {v3, v2}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 91
    :cond_1
    const-string v3, "gcm.n.analytics_data"

    invoke-virtual {v1, v3}, Landroid/os/Bundle;->getBundle(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v3

    .line 97
    .end local v1    # "extras":Landroid/os/Bundle;
    .end local v2    # "messageId":Ljava/lang/String;
    :cond_2
    goto :goto_0

    .line 93
    :catch_0
    move-exception v1

    .line 96
    .local v1, "e":Ljava/lang/RuntimeException;
    const-string v2, "FirebaseMessaging"

    const-string v3, "Failed trying to get analytics data from Intent extras."

    invoke-static {v2, v3, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 98
    .end local v1    # "e":Ljava/lang/RuntimeException;
    :goto_0
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->shouldUploadScionMetrics(Landroid/os/Bundle;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 99
    invoke-static {v0}, Lcom/google/firebase/messaging/MessagingAnalytics;->logNotificationOpen(Landroid/os/Bundle;)V

    .line 101
    :cond_3
    return-void
.end method


# virtual methods
.method synthetic lambda$onActivityCreated$0$com-google-firebase-messaging-FcmLifecycleCallbacks(Landroid/content/Intent;)V
    .locals 0
    .param p1, "startingIntent"    # Landroid/content/Intent;

    .line 54
    invoke-direct {p0, p1}, Lcom/google/firebase/messaging/FcmLifecycleCallbacks;->logNotificationOpen(Landroid/content/Intent;)V

    return-void
.end method

.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1
    .param p1, "createdActivity"    # Landroid/app/Activity;
    .param p2, "instanceState"    # Landroid/os/Bundle;

    .line 44
    invoke-virtual {p1}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 45
    .local v0, "startingIntent":Landroid/content/Intent;
    if-nez v0, :cond_0

    .line 46
    return-void

    .line 49
    :cond_0
    nop

    .line 56
    invoke-direct {p0, v0}, Lcom/google/firebase/messaging/FcmLifecycleCallbacks;->logNotificationOpen(Landroid/content/Intent;)V

    .line 58
    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 0
    .param p1, "destroyedActivity"    # Landroid/app/Activity;

    .line 64
    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 0
    .param p1, "pausedActivity"    # Landroid/app/Activity;

    .line 61
    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 0
    .param p1, "activity"    # Landroid/app/Activity;

    .line 73
    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "bundle"    # Landroid/os/Bundle;

    .line 76
    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 0
    .param p1, "activity"    # Landroid/app/Activity;

    .line 67
    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 0
    .param p1, "activity"    # Landroid/app/Activity;

    .line 70
    return-void
.end method
