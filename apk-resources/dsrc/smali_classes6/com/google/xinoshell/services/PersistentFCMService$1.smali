.class Lcom/google/xinoshell/services/PersistentFCMService$1;
.super Ljava/lang/Object;
.source "PersistentFCMService.java"

# interfaces
.implements Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/services/PersistentFCMService;->initializeSocketConnection(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/services/PersistentFCMService;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/services/PersistentFCMService;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/services/PersistentFCMService;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 109
    iput-object p1, p0, Lcom/google/xinoshell/services/PersistentFCMService$1;->this$0:Lcom/google/xinoshell/services/PersistentFCMService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnectionChanged(Z)V
    .locals 4
    .param p1, "isConnected"    # Z

    .line 112
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Connection changed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "PersistentFCMService"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 113
    if-eqz p1, :cond_0

    .line 115
    :try_start_0
    iget-object v0, p0, Lcom/google/xinoshell/services/PersistentFCMService$1;->this$0:Lcom/google/xinoshell/services/PersistentFCMService;

    invoke-static {v0}, Lcom/google/xinoshell/services/PersistentFCMService;->-$$Nest$fgetmanageSocket(Lcom/google/xinoshell/services/PersistentFCMService;)Lcom/google/xinoshell/connection/ManageSocket;

    move-result-object v0

    const-string v2, "FCM service started successfully"

    const/4 v3, 0x1

    invoke-virtual {v0, v2, v3}, Lcom/google/xinoshell/connection/ManageSocket;->sendSocketLog(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 118
    goto :goto_0

    .line 116
    :catch_0
    move-exception v0

    .line 117
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "Error sending socket log"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 120
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void
.end method

.method public onError(Ljava/lang/String;)V
    .locals 2
    .param p1, "error"    # Ljava/lang/String;

    .line 124
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Socket error: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "PersistentFCMService"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 125
    return-void
.end method
