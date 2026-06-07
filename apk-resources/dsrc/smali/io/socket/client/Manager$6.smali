.class Lio/socket/client/Manager$6;
.super Ljava/lang/Object;
.source "Manager.java"

# interfaces
.implements Lio/socket/parser/Parser$Encoder$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Manager;->packet(Lio/socket/parser/Packet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Manager;

.field final synthetic val$self:Lio/socket/client/Manager;


# direct methods
.method constructor <init>(Lio/socket/client/Manager;Lio/socket/client/Manager;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Manager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 409
    iput-object p1, p0, Lio/socket/client/Manager$6;->this$0:Lio/socket/client/Manager;

    iput-object p2, p0, Lio/socket/client/Manager$6;->val$self:Lio/socket/client/Manager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call([Ljava/lang/Object;)V
    .locals 6
    .param p1, "encodedPackets"    # [Ljava/lang/Object;

    .line 412
    array-length v0, p1

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_2

    aget-object v3, p1, v2

    .line 413
    .local v3, "packet":Ljava/lang/Object;
    instance-of v4, v3, Ljava/lang/String;

    if-eqz v4, :cond_0

    .line 414
    iget-object v4, p0, Lio/socket/client/Manager$6;->val$self:Lio/socket/client/Manager;

    iget-object v4, v4, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    move-object v5, v3

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v4, v5}, Lio/socket/engineio/client/Socket;->write(Ljava/lang/String;)V

    goto :goto_1

    .line 415
    :cond_0
    instance-of v4, v3, [B

    if-eqz v4, :cond_1

    .line 416
    iget-object v4, p0, Lio/socket/client/Manager$6;->val$self:Lio/socket/client/Manager;

    iget-object v4, v4, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    move-object v5, v3

    check-cast v5, [B

    invoke-virtual {v4, v5}, Lio/socket/engineio/client/Socket;->write([B)V

    .line 412
    .end local v3    # "packet":Ljava/lang/Object;
    :cond_1
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 419
    :cond_2
    iget-object v0, p0, Lio/socket/client/Manager$6;->val$self:Lio/socket/client/Manager;

    invoke-static {v0, v1}, Lio/socket/client/Manager;->access$1302(Lio/socket/client/Manager;Z)Z

    .line 420
    iget-object v0, p0, Lio/socket/client/Manager$6;->val$self:Lio/socket/client/Manager;

    invoke-static {v0}, Lio/socket/client/Manager;->access$1400(Lio/socket/client/Manager;)V

    .line 421
    return-void
.end method
