.class Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;
.super Landroid/content/BroadcastReceiver;
.source "SyncTask.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/firebase/messaging/SyncTask;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "ConnectivityChangeReceiver"
.end annotation


# instance fields
.field private receiverContext:Landroid/content/Context;

.field private task:Lcom/google/firebase/messaging/SyncTask;


# direct methods
.method public constructor <init>(Lcom/google/firebase/messaging/SyncTask;)V
    .locals 0
    .param p1, "task"    # Lcom/google/firebase/messaging/SyncTask;

    .line 166
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    .line 167
    iput-object p1, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    .line 168
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .line 186
    iget-object v0, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    if-nez v0, :cond_0

    .line 188
    return-void

    .line 190
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    invoke-virtual {v0}, Lcom/google/firebase/messaging/SyncTask;->isDeviceConnected()Z

    move-result v0

    if-nez v0, :cond_1

    .line 192
    return-void

    .line 194
    :cond_1
    invoke-static {}, Lcom/google/firebase/messaging/SyncTask;->isDebugLogEnabled()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 195
    const-string v0, "FirebaseMessaging"

    const-string v1, "Connectivity changed. Starting background sync."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 197
    :cond_2
    iget-object v0, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    invoke-static {v0}, Lcom/google/firebase/messaging/SyncTask;->access$000(Lcom/google/firebase/messaging/SyncTask;)Lcom/google/firebase/messaging/FirebaseMessaging;

    move-result-object v0

    iget-object v1, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    const-wide/16 v2, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lcom/google/firebase/messaging/FirebaseMessaging;->enqueueTaskWithDelaySeconds(Ljava/lang/Runnable;J)V

    .line 198
    iget-object v0, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->receiverContext:Landroid/content/Context;

    if-eqz v0, :cond_3

    .line 199
    iget-object v0, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->receiverContext:Landroid/content/Context;

    invoke-virtual {v0, p0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 201
    :cond_3
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    .line 202
    return-void
.end method

.method public registerReceiver()V
    .locals 2

    .line 171
    invoke-static {}, Lcom/google/firebase/messaging/SyncTask;->isDebugLogEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 172
    const-string v0, "FirebaseMessaging"

    const-string v1, "Connectivity change received registered"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    :cond_0
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 175
    .local v0, "intentFilter":Landroid/content/IntentFilter;
    iget-object v1, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    if-eqz v1, :cond_1

    .line 176
    iget-object v1, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->task:Lcom/google/firebase/messaging/SyncTask;

    invoke-virtual {v1}, Lcom/google/firebase/messaging/SyncTask;->getContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->receiverContext:Landroid/content/Context;

    .line 177
    iget-object v1, p0, Lcom/google/firebase/messaging/SyncTask$ConnectivityChangeReceiver;->receiverContext:Landroid/content/Context;

    invoke-virtual {v1, p0, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 179
    :cond_1
    return-void
.end method
