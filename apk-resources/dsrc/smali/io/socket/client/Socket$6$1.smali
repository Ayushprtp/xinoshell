.class Lio/socket/client/Socket$6$1;
.super Ljava/util/TimerTask;
.source "Socket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket$6;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/client/Socket$6;

.field final synthetic val$ackId:I

.field final synthetic val$ackWithTimeout:Lio/socket/client/AckWithTimeout;


# direct methods
.method constructor <init>(Lio/socket/client/Socket$6;ILio/socket/client/AckWithTimeout;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/client/Socket$6;

    .line 222
    iput-object p1, p0, Lio/socket/client/Socket$6$1;->this$1:Lio/socket/client/Socket$6;

    iput p2, p0, Lio/socket/client/Socket$6$1;->val$ackId:I

    iput-object p3, p0, Lio/socket/client/Socket$6$1;->val$ackWithTimeout:Lio/socket/client/AckWithTimeout;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 226
    iget-object v0, p0, Lio/socket/client/Socket$6$1;->this$1:Lio/socket/client/Socket$6;

    iget-object v0, v0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v0}, Lio/socket/client/Socket;->access$900(Lio/socket/client/Socket;)Ljava/util/Map;

    move-result-object v0

    iget v1, p0, Lio/socket/client/Socket$6$1;->val$ackId:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 229
    iget-object v0, p0, Lio/socket/client/Socket$6$1;->this$1:Lio/socket/client/Socket$6;

    iget-object v0, v0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v0}, Lio/socket/client/Socket;->access$1000(Lio/socket/client/Socket;)Ljava/util/Queue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Queue;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 230
    .local v0, "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Lio/socket/parser/Packet<Lorg/json/JSONArray;>;>;"
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 231
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/parser/Packet;

    iget v1, v1, Lio/socket/parser/Packet;->id:I

    iget v2, p0, Lio/socket/client/Socket$6$1;->val$ackId:I

    if-ne v1, v2, :cond_0

    .line 232
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    .line 236
    :cond_1
    iget-object v1, p0, Lio/socket/client/Socket$6$1;->val$ackWithTimeout:Lio/socket/client/AckWithTimeout;

    invoke-virtual {v1}, Lio/socket/client/AckWithTimeout;->onTimeout()V

    .line 237
    return-void
.end method
