.class Lio/socket/client/Socket$6;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)Lio/socket/emitter/Emitter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;

.field final synthetic val$ack:Lio/socket/client/Ack;

.field final synthetic val$args:[Ljava/lang/Object;

.field final synthetic val$event:Ljava/lang/String;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 201
    iput-object p1, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    iput-object p2, p0, Lio/socket/client/Socket$6;->val$event:Ljava/lang/String;

    iput-object p3, p0, Lio/socket/client/Socket$6;->val$args:[Ljava/lang/Object;

    iput-object p4, p0, Lio/socket/client/Socket$6;->val$ack:Lio/socket/client/Ack;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .line 204
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 205
    .local v0, "jsonArgs":Lorg/json/JSONArray;
    iget-object v1, p0, Lio/socket/client/Socket$6;->val$event:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 207
    iget-object v1, p0, Lio/socket/client/Socket$6;->val$args:[Ljava/lang/Object;

    if-eqz v1, :cond_0

    .line 208
    iget-object v1, p0, Lio/socket/client/Socket$6;->val$args:[Ljava/lang/Object;

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    aget-object v4, v1, v3

    .line 209
    .local v4, "arg":Ljava/lang/Object;
    invoke-virtual {v0, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 208
    .end local v4    # "arg":Ljava/lang/Object;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 213
    :cond_0
    new-instance v1, Lio/socket/parser/Packet;

    const/4 v2, 0x2

    invoke-direct {v1, v2, v0}, Lio/socket/parser/Packet;-><init>(ILjava/lang/Object;)V

    .line 215
    .local v1, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    iget-object v2, p0, Lio/socket/client/Socket$6;->val$ack:Lio/socket/client/Ack;

    if-eqz v2, :cond_2

    .line 216
    iget-object v2, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v2}, Lio/socket/client/Socket;->access$700(Lio/socket/client/Socket;)I

    move-result v2

    .line 218
    .local v2, "ackId":I
    invoke-static {}, Lio/socket/client/Socket;->access$800()Ljava/util/logging/Logger;

    move-result-object v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    const-string v5, "emitting packet with ack id %d"

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 220
    iget-object v3, p0, Lio/socket/client/Socket$6;->val$ack:Lio/socket/client/Ack;

    instance-of v3, v3, Lio/socket/client/AckWithTimeout;

    if-eqz v3, :cond_1

    .line 221
    iget-object v3, p0, Lio/socket/client/Socket$6;->val$ack:Lio/socket/client/Ack;

    check-cast v3, Lio/socket/client/AckWithTimeout;

    .line 222
    .local v3, "ackWithTimeout":Lio/socket/client/AckWithTimeout;
    new-instance v4, Lio/socket/client/Socket$6$1;

    invoke-direct {v4, p0, v2, v3}, Lio/socket/client/Socket$6$1;-><init>(Lio/socket/client/Socket$6;ILio/socket/client/AckWithTimeout;)V

    invoke-virtual {v3, v4}, Lio/socket/client/AckWithTimeout;->schedule(Ljava/util/TimerTask;)V

    .line 241
    .end local v3    # "ackWithTimeout":Lio/socket/client/AckWithTimeout;
    :cond_1
    iget-object v3, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v3}, Lio/socket/client/Socket;->access$900(Lio/socket/client/Socket;)Ljava/util/Map;

    move-result-object v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    iget-object v5, p0, Lio/socket/client/Socket$6;->val$ack:Lio/socket/client/Ack;

    invoke-interface {v3, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 242
    iget-object v3, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v3}, Lio/socket/client/Socket;->access$708(Lio/socket/client/Socket;)I

    move-result v3

    iput v3, v1, Lio/socket/parser/Packet;->id:I

    .line 245
    .end local v2    # "ackId":I
    :cond_2
    iget-object v2, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v2}, Lio/socket/client/Socket;->access$200(Lio/socket/client/Socket;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 246
    iget-object v2, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v2, v1}, Lio/socket/client/Socket;->access$1100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V

    goto :goto_1

    .line 248
    :cond_3
    iget-object v2, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    invoke-static {v2}, Lio/socket/client/Socket;->access$1000(Lio/socket/client/Socket;)Ljava/util/Queue;

    move-result-object v2

    invoke-interface {v2, v1}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 250
    :goto_1
    return-void
.end method
