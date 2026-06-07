.class Lcom/google/xinoshell/connection/SocketIOClient$1;
.super Ljava/lang/Object;
.source "SocketIOClient.java"

# interfaces
.implements Lcom/google/xinoshell/receivers/NetworkChangeReceiver$NetworkChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/connection/SocketIOClient;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/connection/SocketIOClient;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/connection/SocketIOClient;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/connection/SocketIOClient;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 62
    iput-object p1, p0, Lcom/google/xinoshell/connection/SocketIOClient$1;->this$0:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNetworkAvailable()V
    .locals 1

    .line 65
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient$1;->this$0:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->connect()V

    .line 66
    return-void
.end method

.method public onNetworkLost()V
    .locals 1

    .line 70
    iget-object v0, p0, Lcom/google/xinoshell/connection/SocketIOClient$1;->this$0:Lcom/google/xinoshell/connection/SocketIOClient;

    invoke-virtual {v0}, Lcom/google/xinoshell/connection/SocketIOClient;->disconnect()V

    .line 71
    return-void
.end method
