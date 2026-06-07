.class Lcom/google/xinoshell/services/BgService$3;
.super Ljava/lang/Object;
.source "BgService.java"

# interfaces
.implements Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/services/BgService;->initializeSocketConnection()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/services/BgService;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/services/BgService;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/services/BgService;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 229
    iput-object p1, p0, Lcom/google/xinoshell/services/BgService$3;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnectionChanged(Z)V
    .locals 3
    .param p1, "isConnected"    # Z

    .line 233
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Connection changed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BgService"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 234
    if-eqz p1, :cond_0

    .line 235
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService$3;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v0}, Lcom/google/xinoshell/services/BgService;->-$$Nest$fgetmanageSocket(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/connection/ManageSocket;

    move-result-object v0

    const-string v1, "Foreground service started successfully "

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/google/xinoshell/connection/ManageSocket;->sendSocketLog(Ljava/lang/String;I)V

    .line 237
    :cond_0
    return-void
.end method

.method public onError(Ljava/lang/String;)V
    .locals 2
    .param p1, "error"    # Ljava/lang/String;

    .line 241
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Socket error: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BgService"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 242
    return-void
.end method
