.class Lio/socket/client/Socket$5;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;

.field final synthetic val$args:[Ljava/lang/Object;

.field final synthetic val$event:Ljava/lang/String;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;[Ljava/lang/Object;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 168
    iput-object p1, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    iput-object p2, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    iput-object p3, p0, Lio/socket/client/Socket$5;->val$event:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 173
    iget-object v0, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    .line 175
    .local v0, "lastIndex":I
    iget-object v1, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    array-length v1, v1

    if-lez v1, :cond_1

    iget-object v1, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    aget-object v1, v1, v0

    instance-of v1, v1, Lio/socket/client/Ack;

    if-eqz v1, :cond_1

    .line 176
    new-array v1, v0, [Ljava/lang/Object;

    .line 177
    .local v1, "_args":[Ljava/lang/Object;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_0

    .line 178
    iget-object v3, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    aget-object v3, v3, v2

    aput-object v3, v1, v2

    .line 177
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 180
    .end local v2    # "i":I
    :cond_0
    iget-object v2, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    aget-object v2, v2, v0

    check-cast v2, Lio/socket/client/Ack;

    .local v2, "ack":Lio/socket/client/Ack;
    goto :goto_1

    .line 182
    .end local v1    # "_args":[Ljava/lang/Object;
    .end local v2    # "ack":Lio/socket/client/Ack;
    :cond_1
    iget-object v1, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    .line 183
    .restart local v1    # "_args":[Ljava/lang/Object;
    const/4 v2, 0x0

    .line 186
    .restart local v2    # "ack":Lio/socket/client/Ack;
    :goto_1
    iget-object v3, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    iget-object v4, p0, Lio/socket/client/Socket$5;->val$event:Ljava/lang/String;

    invoke-virtual {v3, v4, v1, v2}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)Lio/socket/emitter/Emitter;

    .line 187
    return-void
.end method
