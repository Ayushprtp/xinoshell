.class public Lio/socket/client/Socket;
.super Lio/socket/emitter/Emitter;
.source "Socket.java"


# static fields
.field public static final EVENT_CONNECT:Ljava/lang/String; = "connect"

.field public static final EVENT_CONNECT_ERROR:Ljava/lang/String; = "connect_error"

.field public static final EVENT_DISCONNECT:Ljava/lang/String; = "disconnect"

.field static final EVENT_MESSAGE:Ljava/lang/String; = "message"

.field protected static RESERVED_EVENTS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static final logger:Ljava/util/logging/Logger;


# instance fields
.field private final acks:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Lio/socket/client/Ack;",
            ">;"
        }
    .end annotation
.end field

.field private final auth:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private volatile connected:Z

.field id:Ljava/lang/String;

.field private ids:I

.field private final io:Lio/socket/client/Manager;

.field private final nsp:Ljava/lang/String;

.field private final onAnyIncomingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentLinkedQueue<",
            "Lio/socket/emitter/Emitter$Listener;",
            ">;"
        }
    .end annotation
.end field

.field private final onAnyOutgoingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentLinkedQueue<",
            "Lio/socket/emitter/Emitter$Listener;",
            ">;"
        }
    .end annotation
.end field

.field private final receiveBuffer:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Ljava/util/List<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field private final sendBuffer:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Lio/socket/parser/Packet<",
            "Lorg/json/JSONArray;",
            ">;>;"
        }
    .end annotation
.end field

.field private subs:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Lio/socket/client/On$Handle;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 22
    const-class v0, Lio/socket/client/Socket;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    .line 46
    new-instance v0, Lio/socket/client/Socket$1;

    invoke-direct {v0}, Lio/socket/client/Socket$1;-><init>()V

    sput-object v0, Lio/socket/client/Socket;->RESERVED_EVENTS:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>(Lio/socket/client/Manager;Ljava/lang/String;Lio/socket/client/Manager$Options;)V
    .locals 1
    .param p1, "io"    # Lio/socket/client/Manager;
    .param p2, "nsp"    # Ljava/lang/String;
    .param p3, "opts"    # Lio/socket/client/Manager$Options;

    .line 71
    invoke-direct {p0}, Lio/socket/emitter/Emitter;-><init>()V

    .line 63
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    .line 65
    new-instance v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    .line 66
    new-instance v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    .line 68
    new-instance v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->onAnyIncomingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 69
    new-instance v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->onAnyOutgoingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 72
    iput-object p1, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    .line 73
    iput-object p2, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    .line 74
    if-eqz p3, :cond_0

    iget-object v0, p3, Lio/socket/client/Manager$Options;->auth:Ljava/util/Map;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-object v0, p0, Lio/socket/client/Socket;->auth:Ljava/util/Map;

    .line 75
    return-void
.end method

.method static synthetic access$000(Lio/socket/client/Socket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    invoke-direct {p0}, Lio/socket/client/Socket;->onopen()V

    return-void
.end method

.method static synthetic access$100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Lio/socket/parser/Packet;

    .line 20
    invoke-direct {p0, p1}, Lio/socket/client/Socket;->onpacket(Lio/socket/parser/Packet;)V

    return-void
.end method

.method static synthetic access$1000(Lio/socket/client/Socket;)Ljava/util/Queue;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    iget-object v0, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    return-object v0
.end method

.method static synthetic access$1100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Lio/socket/parser/Packet;

    .line 20
    invoke-direct {p0, p1}, Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V

    return-void
.end method

.method static synthetic access$1200(Lio/socket/client/Socket;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    iget-object v0, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1300(Lio/socket/client/Socket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    invoke-direct {p0}, Lio/socket/client/Socket;->destroy()V

    return-void
.end method

.method static synthetic access$200(Lio/socket/client/Socket;)Z
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    iget-boolean v0, p0, Lio/socket/client/Socket;->connected:Z

    return v0
.end method

.method static synthetic access$301(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # [Ljava/lang/Object;

    .line 20
    invoke-super {p0, p1, p2}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$400(Lio/socket/client/Socket;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Ljava/lang/String;

    .line 20
    invoke-direct {p0, p1}, Lio/socket/client/Socket;->onclose(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$500(Lio/socket/client/Socket;)Lio/socket/client/Manager;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    return-object v0
.end method

.method static synthetic access$600(Lio/socket/client/Socket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    invoke-direct {p0}, Lio/socket/client/Socket;->subEvents()V

    return-void
.end method

.method static synthetic access$700(Lio/socket/client/Socket;)I
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    iget v0, p0, Lio/socket/client/Socket;->ids:I

    return v0
.end method

.method static synthetic access$708(Lio/socket/client/Socket;)I
    .locals 2
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    iget v0, p0, Lio/socket/client/Socket;->ids:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lio/socket/client/Socket;->ids:I

    return v0
.end method

.method static synthetic access$800()Ljava/util/logging/Logger;
    .locals 1

    .line 20
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method

.method static synthetic access$900(Lio/socket/client/Socket;)Ljava/util/Map;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .line 20
    iget-object v0, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    return-object v0
.end method

.method private ack(I)Lio/socket/client/Ack;
    .locals 3
    .param p1, "id"    # I

    .line 372
    move-object v0, p0

    .line 373
    .local v0, "self":Lio/socket/client/Socket;
    const/4 v1, 0x1

    new-array v1, v1, [Z

    const/4 v2, 0x0

    aput-boolean v2, v1, v2

    .line 374
    .local v1, "sent":[Z
    new-instance v2, Lio/socket/client/Socket$7;

    invoke-direct {v2, p0, v1, p1, v0}, Lio/socket/client/Socket$7;-><init>(Lio/socket/client/Socket;[ZILio/socket/client/Socket;)V

    return-object v2
.end method

.method private clearAcks()V
    .locals 3

    .line 293
    iget-object v0, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/client/Ack;

    .line 294
    .local v1, "ack":Lio/socket/client/Ack;
    instance-of v2, v1, Lio/socket/client/AckWithTimeout;

    if-eqz v2, :cond_0

    .line 295
    move-object v2, v1

    check-cast v2, Lio/socket/client/AckWithTimeout;

    invoke-virtual {v2}, Lio/socket/client/AckWithTimeout;->onTimeout()V

    .line 298
    .end local v1    # "ack":Lio/socket/client/Ack;
    :cond_0
    goto :goto_0

    .line 299
    :cond_1
    iget-object v0, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 300
    return-void
.end method

.method private destroy()V
    .locals 2

    .line 445
    iget-object v0, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    if-eqz v0, :cond_1

    .line 447
    iget-object v0, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/client/On$Handle;

    .line 448
    .local v1, "sub":Lio/socket/client/On$Handle;
    invoke-interface {v1}, Lio/socket/client/On$Handle;->destroy()V

    .line 449
    .end local v1    # "sub":Lio/socket/client/On$Handle;
    goto :goto_0

    .line 450
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    .line 453
    :cond_1
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    invoke-virtual {v0}, Lio/socket/client/Manager;->destroy()V

    .line 454
    return-void
.end method

.method private emitBuffered()V
    .locals 3

    .line 423
    nop

    :goto_0
    iget-object v0, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    move-object v1, v0

    .local v1, "data":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    if-eqz v0, :cond_0

    .line 424
    const/4 v0, 0x0

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 425
    .local v0, "event":Ljava/lang/String;
    invoke-interface {v1}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v2

    invoke-super {p0, v0, v2}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 426
    .end local v0    # "event":Ljava/lang/String;
    goto :goto_0

    .line 427
    :cond_0
    iget-object v0, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->clear()V

    .line 430
    :goto_1
    iget-object v0, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/socket/parser/Packet;

    move-object v2, v0

    .local v2, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    if-eqz v0, :cond_1

    .line 431
    invoke-direct {p0, v2}, Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V

    goto :goto_1

    .line 433
    :cond_1
    iget-object v0, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->clear()V

    .line 434
    return-void
.end method

.method private onack(Lio/socket/parser/Packet;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/parser/Packet<",
            "Lorg/json/JSONArray;",
            ">;)V"
        }
    .end annotation

    .line 401
    .local p1, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    iget-object v0, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    iget v1, p1, Lio/socket/parser/Packet;->id:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/socket/client/Ack;

    .line 402
    .local v0, "fn":Lio/socket/client/Ack;
    if-eqz v0, :cond_1

    .line 403
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    sget-object v2, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 404
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    iget v2, p1, Lio/socket/parser/Packet;->id:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iget-object v3, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "calling ack %s with %s"

    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 406
    :cond_0
    iget-object v1, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    check-cast v1, Lorg/json/JSONArray;

    invoke-static {v1}, Lio/socket/client/Socket;->toArray(Lorg/json/JSONArray;)[Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lio/socket/client/Ack;->call([Ljava/lang/Object;)V

    goto :goto_0

    .line 408
    :cond_1
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    sget-object v2, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 409
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    iget v2, p1, Lio/socket/parser/Packet;->id:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "bad ack %s"

    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 412
    :cond_2
    :goto_0
    return-void
.end method

.method private onclose(Ljava/lang/String;)V
    .locals 3
    .param p1, "reason"    # Ljava/lang/String;

    .line 279
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    sget-object v1, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 280
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v1, "close (%s)"

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 282
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/socket/client/Socket;->connected:Z

    .line 283
    const/4 v0, 0x0

    iput-object v0, p0, Lio/socket/client/Socket;->id:Ljava/lang/String;

    .line 284
    const-string v0, "disconnect"

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-super {p0, v0, v1}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 285
    invoke-direct {p0}, Lio/socket/client/Socket;->clearAcks()V

    .line 286
    return-void
.end method

.method private onconnect(Ljava/lang/String;)V
    .locals 2
    .param p1, "id"    # Ljava/lang/String;

    .line 415
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/socket/client/Socket;->connected:Z

    .line 416
    iput-object p1, p0, Lio/socket/client/Socket;->id:Ljava/lang/String;

    .line 417
    invoke-direct {p0}, Lio/socket/client/Socket;->emitBuffered()V

    .line 418
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "connect"

    invoke-super {p0, v1, v0}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 419
    return-void
.end method

.method private ondisconnect()V
    .locals 3

    .line 437
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    sget-object v1, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 438
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    iget-object v1, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "server disconnect (%s)"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 440
    :cond_0
    invoke-direct {p0}, Lio/socket/client/Socket;->destroy()V

    .line 441
    const-string v0, "io server disconnect"

    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onclose(Ljava/lang/String;)V

    .line 442
    return-void
.end method

.method private onevent(Lio/socket/parser/Packet;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/parser/Packet<",
            "Lorg/json/JSONArray;",
            ">;)V"
        }
    .end annotation

    .line 346
    .local p1, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    check-cast v1, Lorg/json/JSONArray;

    invoke-static {v1}, Lio/socket/client/Socket;->toArray(Lorg/json/JSONArray;)[Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 347
    .local v0, "args":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    sget-object v2, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 348
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v2, "emitting event %s"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 351
    :cond_0
    iget v1, p1, Lio/socket/parser/Packet;->id:I

    if-ltz v1, :cond_1

    .line 352
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v2, "attaching ack callback to event"

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 353
    iget v1, p1, Lio/socket/parser/Packet;->id:I

    invoke-direct {p0, v1}, Lio/socket/client/Socket;->ack(I)Lio/socket/client/Ack;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 356
    :cond_1
    iget-boolean v1, p0, Lio/socket/client/Socket;->connected:Z

    if-eqz v1, :cond_4

    .line 357
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    return-void

    .line 358
    :cond_2
    iget-object v1, p0, Lio/socket/client/Socket;->onAnyIncomingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v1}, Ljava/util/concurrent/ConcurrentLinkedQueue;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    .line 359
    invoke-interface {v0}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v1

    .line 360
    .local v1, "argsAsArray":[Ljava/lang/Object;
    iget-object v2, p0, Lio/socket/client/Socket;->onAnyIncomingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentLinkedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lio/socket/emitter/Emitter$Listener;

    .line 361
    .local v3, "listener":Lio/socket/emitter/Emitter$Listener;
    invoke-interface {v3, v1}, Lio/socket/emitter/Emitter$Listener;->call([Ljava/lang/Object;)V

    .line 362
    .end local v3    # "listener":Lio/socket/emitter/Emitter$Listener;
    goto :goto_0

    .line 364
    .end local v1    # "argsAsArray":[Ljava/lang/Object;
    :cond_3
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 365
    .local v1, "event":Ljava/lang/String;
    invoke-interface {v0}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v2

    invoke-super {p0, v1, v2}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 366
    .end local v1    # "event":Ljava/lang/String;
    goto :goto_1

    .line 367
    :cond_4
    iget-object v1, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    invoke-interface {v1, v0}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 369
    :goto_1
    return-void
.end method

.method private onopen()V
    .locals 4

    .line 269
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v1, "transport is open - connecting"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 271
    iget-object v0, p0, Lio/socket/client/Socket;->auth:Ljava/util/Map;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 272
    new-instance v0, Lio/socket/parser/Packet;

    new-instance v2, Lorg/json/JSONObject;

    iget-object v3, p0, Lio/socket/client/Socket;->auth:Ljava/util/Map;

    invoke-direct {v2, v3}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    invoke-direct {v0, v1, v2}, Lio/socket/parser/Packet;-><init>(ILjava/lang/Object;)V

    invoke-direct {p0, v0}, Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V

    goto :goto_0

    .line 274
    :cond_0
    new-instance v0, Lio/socket/parser/Packet;

    invoke-direct {v0, v1}, Lio/socket/parser/Packet;-><init>(I)V

    invoke-direct {p0, v0}, Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V

    .line 276
    :goto_0
    return-void
.end method

.method private onpacket(Lio/socket/parser/Packet;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/parser/Packet<",
            "*>;)V"
        }
    .end annotation

    .line 303
    .local p1, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<*>;"
    iget-object v0, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    iget-object v1, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 305
    :cond_0
    iget v0, p1, Lio/socket/parser/Packet;->type:I

    const-string v1, "connect_error"

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 339
    :pswitch_0
    invoke-direct {p0}, Lio/socket/client/Socket;->destroy()V

    .line 340
    iget-object v0, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-super {p0, v1, v0}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0

    .line 329
    :pswitch_1
    move-object v0, p1

    .line 330
    .local v0, "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onack(Lio/socket/parser/Packet;)V

    .line 331
    goto :goto_0

    .line 321
    .end local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    :pswitch_2
    move-object v0, p1

    .line 322
    .restart local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onevent(Lio/socket/parser/Packet;)V

    .line 323
    goto :goto_0

    .line 335
    .end local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    :pswitch_3
    invoke-direct {p0}, Lio/socket/client/Socket;->ondisconnect()V

    .line 336
    goto :goto_0

    .line 307
    :pswitch_4
    iget-object v0, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    instance-of v0, v0, Lorg/json/JSONObject;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    check-cast v0, Lorg/json/JSONObject;

    const-string v2, "sid"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 309
    :try_start_0
    iget-object v0, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    check-cast v0, Lorg/json/JSONObject;

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onconnect(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 310
    return-void

    .line 311
    :catch_0
    move-exception v0

    goto :goto_0

    .line 313
    :cond_1
    new-instance v0, Lio/socket/client/SocketIOException;

    const-string v2, "It seems you are trying to reach a Socket.IO server in v2.x with a v3.x client, which is not possible"

    invoke-direct {v0, v2}, Lio/socket/client/SocketIOException;-><init>(Ljava/lang/String;)V

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-super {p0, v1, v0}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 315
    nop

    .line 343
    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private packet(Lio/socket/parser/Packet;)V
    .locals 3
    .param p1, "packet"    # Lio/socket/parser/Packet;

    .line 256
    iget v0, p1, Lio/socket/parser/Packet;->type:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 257
    iget-object v0, p0, Lio/socket/client/Socket;->onAnyOutgoingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 258
    iget-object v0, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    check-cast v0, Lorg/json/JSONArray;

    invoke-static {v0}, Lio/socket/client/Socket;->toArray(Lorg/json/JSONArray;)[Ljava/lang/Object;

    move-result-object v0

    .line 259
    .local v0, "argsAsArray":[Ljava/lang/Object;
    iget-object v1, p0, Lio/socket/client/Socket;->onAnyOutgoingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v1}, Ljava/util/concurrent/ConcurrentLinkedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/socket/emitter/Emitter$Listener;

    .line 260
    .local v2, "listener":Lio/socket/emitter/Emitter$Listener;
    invoke-interface {v2, v0}, Lio/socket/emitter/Emitter$Listener;->call([Ljava/lang/Object;)V

    .line 261
    .end local v2    # "listener":Lio/socket/emitter/Emitter$Listener;
    goto :goto_0

    .line 264
    .end local v0    # "argsAsArray":[Ljava/lang/Object;
    :cond_0
    iget-object v0, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    iput-object v0, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    .line 265
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    invoke-virtual {v0, p1}, Lio/socket/client/Manager;->packet(Lio/socket/parser/Packet;)V

    .line 266
    return-void
.end method

.method private subEvents()V
    .locals 2

    .line 78
    iget-object v0, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    if-eqz v0, :cond_0

    return-void

    .line 80
    :cond_0
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    .line 81
    .local v0, "io":Lio/socket/client/Manager;
    new-instance v1, Lio/socket/client/Socket$2;

    invoke-direct {v1, p0, v0}, Lio/socket/client/Socket$2;-><init>(Lio/socket/client/Socket;Lio/socket/client/Manager;)V

    iput-object v1, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    .line 109
    return-void
.end method

.method private static toArray(Lorg/json/JSONArray;)[Ljava/lang/Object;
    .locals 7
    .param p0, "array"    # Lorg/json/JSONArray;

    .line 511
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v0

    .line 512
    .local v0, "length":I
    new-array v1, v0, [Ljava/lang/Object;

    .line 513
    .local v1, "data":[Ljava/lang/Object;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_1

    .line 516
    :try_start_0
    invoke-virtual {p0, v2}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v3
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 520
    .local v3, "v":Ljava/lang/Object;
    goto :goto_1

    .line 517
    .end local v3    # "v":Ljava/lang/Object;
    :catch_0
    move-exception v3

    .line 518
    .local v3, "e":Lorg/json/JSONException;
    sget-object v4, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    sget-object v5, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v6, "An error occured while retrieving data from JSONArray"

    invoke-virtual {v4, v5, v6, v3}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 519
    const/4 v4, 0x0

    move-object v3, v4

    .line 521
    .local v3, "v":Ljava/lang/Object;
    :goto_1
    sget-object v4, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    invoke-virtual {v4, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 v4, 0x0

    goto :goto_2

    :cond_0
    move-object v4, v3

    :goto_2
    aput-object v4, v1, v2

    .line 513
    .end local v3    # "v":Ljava/lang/Object;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 523
    .end local v2    # "i":I
    :cond_1
    return-object v1
.end method


# virtual methods
.method public close()Lio/socket/client/Socket;
    .locals 1

    .line 462
    new-instance v0, Lio/socket/client/Socket$8;

    invoke-direct {v0, p0}, Lio/socket/client/Socket$8;-><init>(Lio/socket/client/Socket;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 479
    return-object p0
.end method

.method public connect()Lio/socket/client/Socket;
    .locals 1

    .line 136
    invoke-virtual {p0}, Lio/socket/client/Socket;->open()Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public connected()Z
    .locals 1

    .line 496
    iget-boolean v0, p0, Lio/socket/client/Socket;->connected:Z

    return v0
.end method

.method public disconnect()Lio/socket/client/Socket;
    .locals 1

    .line 488
    invoke-virtual {p0}, Lio/socket/client/Socket;->close()Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public varargs emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
    .locals 3
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 164
    sget-object v0, Lio/socket/client/Socket;->RESERVED_EVENTS:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 168
    new-instance v0, Lio/socket/client/Socket$5;

    invoke-direct {v0, p0, p2, p1}, Lio/socket/client/Socket$5;-><init>(Lio/socket/client/Socket;[Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 189
    return-object p0

    .line 165
    :cond_0
    new-instance v0, Ljava/lang/RuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' is a reserved event name"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public emit(Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)Lio/socket/emitter/Emitter;
    .locals 1
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;
    .param p3, "ack"    # Lio/socket/client/Ack;

    .line 201
    new-instance v0, Lio/socket/client/Socket$6;

    invoke-direct {v0, p0, p1, p2, p3}, Lio/socket/client/Socket$6;-><init>(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 252
    return-object p0
.end method

.method public id()Ljava/lang/String;
    .locals 1

    .line 507
    iget-object v0, p0, Lio/socket/client/Socket;->id:Ljava/lang/String;

    return-object v0
.end method

.method public io()Lio/socket/client/Manager;
    .locals 1

    .line 492
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    return-object v0
.end method

.method public isActive()Z
    .locals 1

    .line 112
    iget-object v0, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public offAnyIncoming()Lio/socket/client/Socket;
    .locals 1

    .line 532
    iget-object v0, p0, Lio/socket/client/Socket;->onAnyIncomingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->clear()V

    .line 533
    return-object p0
.end method

.method public offAnyIncoming(Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/Socket;
    .locals 2
    .param p1, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .line 537
    iget-object v0, p0, Lio/socket/client/Socket;->onAnyIncomingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 538
    .local v0, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Lio/socket/emitter/Emitter$Listener;>;"
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 539
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/emitter/Emitter$Listener;

    .line 540
    .local v1, "listener":Lio/socket/emitter/Emitter$Listener;
    if-ne v1, p1, :cond_0

    .line 541
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 542
    goto :goto_1

    .line 544
    .end local v1    # "listener":Lio/socket/emitter/Emitter$Listener;
    :cond_0
    goto :goto_0

    .line 545
    :cond_1
    :goto_1
    return-object p0
.end method

.method public offAnyOutgoing()Lio/socket/client/Socket;
    .locals 1

    .line 554
    iget-object v0, p0, Lio/socket/client/Socket;->onAnyOutgoingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->clear()V

    .line 555
    return-object p0
.end method

.method public offAnyOutgoing(Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/Socket;
    .locals 2
    .param p1, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .line 559
    iget-object v0, p0, Lio/socket/client/Socket;->onAnyOutgoingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 560
    .local v0, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Lio/socket/emitter/Emitter$Listener;>;"
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 561
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/emitter/Emitter$Listener;

    .line 562
    .local v1, "listener":Lio/socket/emitter/Emitter$Listener;
    if-ne v1, p1, :cond_0

    .line 563
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 564
    goto :goto_1

    .line 566
    .end local v1    # "listener":Lio/socket/emitter/Emitter$Listener;
    :cond_0
    goto :goto_0

    .line 567
    :cond_1
    :goto_1
    return-object p0
.end method

.method public onAnyIncoming(Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/Socket;
    .locals 1
    .param p1, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .line 527
    iget-object v0, p0, Lio/socket/client/Socket;->onAnyIncomingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentLinkedQueue;->add(Ljava/lang/Object;)Z

    .line 528
    return-object p0
.end method

.method public onAnyOutgoing(Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/Socket;
    .locals 1
    .param p1, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .line 549
    iget-object v0, p0, Lio/socket/client/Socket;->onAnyOutgoingListeners:Ljava/util/concurrent/ConcurrentLinkedQueue;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentLinkedQueue;->add(Ljava/lang/Object;)Z

    .line 550
    return-object p0
.end method

.method public open()Lio/socket/client/Socket;
    .locals 1

    .line 119
    new-instance v0, Lio/socket/client/Socket$3;

    invoke-direct {v0, p0}, Lio/socket/client/Socket$3;-><init>(Lio/socket/client/Socket;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 129
    return-object p0
.end method

.method public varargs send([Ljava/lang/Object;)Lio/socket/client/Socket;
    .locals 1
    .param p1, "args"    # [Ljava/lang/Object;

    .line 146
    new-instance v0, Lio/socket/client/Socket$4;

    invoke-direct {v0, p0, p1}, Lio/socket/client/Socket$4;-><init>(Lio/socket/client/Socket;[Ljava/lang/Object;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 152
    return-object p0
.end method
