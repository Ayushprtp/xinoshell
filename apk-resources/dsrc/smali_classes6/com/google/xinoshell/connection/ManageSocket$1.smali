.class Lcom/google/xinoshell/connection/ManageSocket$1;
.super Ljava/lang/Object;
.source "ManageSocket.java"

# interfaces
.implements Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/connection/ManageSocket;->initializeSocket()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/connection/ManageSocket;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/connection/ManageSocket;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/connection/ManageSocket;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 63
    iput-object p1, p0, Lcom/google/xinoshell/connection/ManageSocket$1;->this$0:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnectionStateChanged(Z)V
    .locals 1
    .param p1, "isConnected"    # Z

    .line 71
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket$1;->this$0:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-static {v0}, Lcom/google/xinoshell/connection/ManageSocket;->-$$Nest$fgetcallback(Lcom/google/xinoshell/connection/ManageSocket;)Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 72
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket$1;->this$0:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-static {v0}, Lcom/google/xinoshell/connection/ManageSocket;->-$$Nest$fgetcallback(Lcom/google/xinoshell/connection/ManageSocket;)Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/google/xinoshell/connection/ManageSocket$SocketCallback;->onConnectionChanged(Z)V

    .line 74
    :cond_0
    if-eqz p1, :cond_1

    .line 75
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket$1;->this$0:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-static {v0}, Lcom/google/xinoshell/connection/ManageSocket;->-$$Nest$mregisterDefaultListeners(Lcom/google/xinoshell/connection/ManageSocket;)V

    .line 77
    :cond_1
    return-void
.end method

.method public varargs onEventReceived(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p1, "eventName"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 67
    return-void
.end method
