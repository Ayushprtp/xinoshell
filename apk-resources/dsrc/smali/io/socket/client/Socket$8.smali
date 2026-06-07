.class Lio/socket/client/Socket$8;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->close()Lio/socket/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;

    .line 462
    iput-object p1, p0, Lio/socket/client/Socket$8;->this$0:Lio/socket/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 465
    iget-object v0, p0, Lio/socket/client/Socket$8;->this$0:Lio/socket/client/Socket;

    invoke-static {v0}, Lio/socket/client/Socket;->access$200(Lio/socket/client/Socket;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 466
    invoke-static {}, Lio/socket/client/Socket;->access$800()Ljava/util/logging/Logger;

    move-result-object v0

    sget-object v1, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 467
    invoke-static {}, Lio/socket/client/Socket;->access$800()Ljava/util/logging/Logger;

    move-result-object v0

    iget-object v1, p0, Lio/socket/client/Socket$8;->this$0:Lio/socket/client/Socket;

    invoke-static {v1}, Lio/socket/client/Socket;->access$1200(Lio/socket/client/Socket;)Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "performing disconnect (%s)"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 469
    :cond_0
    iget-object v0, p0, Lio/socket/client/Socket$8;->this$0:Lio/socket/client/Socket;

    new-instance v1, Lio/socket/parser/Packet;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Lio/socket/parser/Packet;-><init>(I)V

    invoke-static {v0, v1}, Lio/socket/client/Socket;->access$1100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V

    .line 472
    :cond_1
    iget-object v0, p0, Lio/socket/client/Socket$8;->this$0:Lio/socket/client/Socket;

    invoke-static {v0}, Lio/socket/client/Socket;->access$1300(Lio/socket/client/Socket;)V

    .line 474
    iget-object v0, p0, Lio/socket/client/Socket$8;->this$0:Lio/socket/client/Socket;

    invoke-static {v0}, Lio/socket/client/Socket;->access$200(Lio/socket/client/Socket;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 475
    iget-object v0, p0, Lio/socket/client/Socket$8;->this$0:Lio/socket/client/Socket;

    const-string v1, "io client disconnect"

    invoke-static {v0, v1}, Lio/socket/client/Socket;->access$400(Lio/socket/client/Socket;Ljava/lang/String;)V

    .line 477
    :cond_2
    return-void
.end method
