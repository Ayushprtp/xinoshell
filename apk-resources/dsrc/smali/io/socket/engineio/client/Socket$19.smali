.class Lio/socket/engineio/client/Socket$19;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->close()Lio/socket/engineio/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .line 720
    iput-object p1, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 723
    iget-object v0, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    invoke-static {v0}, Lio/socket/engineio/client/Socket;->access$500(Lio/socket/engineio/client/Socket;)Lio/socket/engineio/client/Socket$ReadyState;

    move-result-object v0

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->OPENING:Lio/socket/engineio/client/Socket$ReadyState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    invoke-static {v0}, Lio/socket/engineio/client/Socket;->access$500(Lio/socket/engineio/client/Socket;)Lio/socket/engineio/client/Socket$ReadyState;

    move-result-object v0

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->OPEN:Lio/socket/engineio/client/Socket$ReadyState;

    if-ne v0, v1, :cond_3

    .line 724
    :cond_0
    iget-object v0, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->CLOSING:Lio/socket/engineio/client/Socket$ReadyState;

    invoke-static {v0, v1}, Lio/socket/engineio/client/Socket;->access$502(Lio/socket/engineio/client/Socket;Lio/socket/engineio/client/Socket$ReadyState;)Lio/socket/engineio/client/Socket$ReadyState;

    .line 726
    iget-object v0, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    .line 728
    .local v0, "self":Lio/socket/engineio/client/Socket;
    new-instance v1, Lio/socket/engineio/client/Socket$19$1;

    invoke-direct {v1, p0, v0}, Lio/socket/engineio/client/Socket$19$1;-><init>(Lio/socket/engineio/client/Socket$19;Lio/socket/engineio/client/Socket;)V

    .line 737
    .local v1, "close":Ljava/lang/Runnable;
    const/4 v2, 0x1

    new-array v2, v2, [Lio/socket/emitter/Emitter$Listener;

    .line 738
    .local v2, "cleanupAndClose":[Lio/socket/emitter/Emitter$Listener;
    new-instance v3, Lio/socket/engineio/client/Socket$19$2;

    invoke-direct {v3, p0, v0, v2, v1}, Lio/socket/engineio/client/Socket$19$2;-><init>(Lio/socket/engineio/client/Socket$19;Lio/socket/engineio/client/Socket;[Lio/socket/emitter/Emitter$Listener;Ljava/lang/Runnable;)V

    const/4 v4, 0x0

    aput-object v3, v2, v4

    .line 747
    new-instance v3, Lio/socket/engineio/client/Socket$19$3;

    invoke-direct {v3, p0, v0, v2}, Lio/socket/engineio/client/Socket$19$3;-><init>(Lio/socket/engineio/client/Socket$19;Lio/socket/engineio/client/Socket;[Lio/socket/emitter/Emitter$Listener;)V

    .line 756
    .local v3, "waitForUpgrade":Ljava/lang/Runnable;
    iget-object v4, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    iget-object v4, v4, Lio/socket/engineio/client/Socket;->writeBuffer:Ljava/util/LinkedList;

    invoke-virtual {v4}, Ljava/util/LinkedList;->size()I

    move-result v4

    if-lez v4, :cond_1

    .line 757
    iget-object v4, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    new-instance v5, Lio/socket/engineio/client/Socket$19$4;

    invoke-direct {v5, p0, v3, v1}, Lio/socket/engineio/client/Socket$19$4;-><init>(Lio/socket/engineio/client/Socket$19;Ljava/lang/Runnable;Ljava/lang/Runnable;)V

    const-string v6, "drain"

    invoke-virtual {v4, v6, v5}, Lio/socket/engineio/client/Socket;->once(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    goto :goto_0

    .line 767
    :cond_1
    iget-object v4, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    invoke-static {v4}, Lio/socket/engineio/client/Socket;->access$1300(Lio/socket/engineio/client/Socket;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 768
    invoke-interface {v3}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 770
    :cond_2
    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 773
    .end local v0    # "self":Lio/socket/engineio/client/Socket;
    .end local v1    # "close":Ljava/lang/Runnable;
    .end local v2    # "cleanupAndClose":[Lio/socket/emitter/Emitter$Listener;
    .end local v3    # "waitForUpgrade":Ljava/lang/Runnable;
    :cond_3
    :goto_0
    return-void
.end method
