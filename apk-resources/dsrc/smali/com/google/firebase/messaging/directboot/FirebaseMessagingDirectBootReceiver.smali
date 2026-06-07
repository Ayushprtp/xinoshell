.class public final Lcom/google/firebase/messaging/directboot/FirebaseMessagingDirectBootReceiver;
.super Lcom/google/android/gms/cloudmessaging/CloudMessagingReceiver;
.source "FirebaseMessagingDirectBootReceiver.java"


# static fields
.field static final TAG:Ljava/lang/String; = "FCM"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 52
    invoke-direct {p0}, Lcom/google/android/gms/cloudmessaging/CloudMessagingReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method protected onMessageReceive(Landroid/content/Context;Lcom/google/android/gms/cloudmessaging/CloudMessage;)I
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "message"    # Lcom/google/android/gms/cloudmessaging/CloudMessage;

    .line 62
    :try_start_0
    new-instance v0, Lcom/google/firebase/messaging/FcmBroadcastProcessor;

    invoke-direct {v0, p1}, Lcom/google/firebase/messaging/FcmBroadcastProcessor;-><init>(Landroid/content/Context;)V

    invoke-virtual {p2}, Lcom/google/android/gms/cloudmessaging/CloudMessage;->getIntent()Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/firebase/messaging/FcmBroadcastProcessor;->process(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->await(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_0
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 63
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 64
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    const-string v1, "FCM"

    const-string v2, "Failed to send message to service."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 65
    const/16 v1, 0x1f4

    return v1
.end method
