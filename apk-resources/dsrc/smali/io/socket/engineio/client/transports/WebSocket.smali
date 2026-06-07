.class public Lio/socket/engineio/client/transports/WebSocket;
.super Lio/socket/engineio/client/Transport;
.source "WebSocket.java"


# static fields
.field public static final NAME:Ljava/lang/String; = "websocket"

.field private static final logger:Ljava/util/logging/Logger;


# instance fields
.field private ws:Lokhttp3/WebSocket;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 26
    const-class v0, Lio/socket/engineio/client/transports/PollingXHR;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/engineio/client/transports/WebSocket;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>(Lio/socket/engineio/client/Transport$Options;)V
    .locals 1
    .param p1, "opts"    # Lio/socket/engineio/client/Transport$Options;

    .line 31
    invoke-direct {p0, p1}, Lio/socket/engineio/client/Transport;-><init>(Lio/socket/engineio/client/Transport$Options;)V

    .line 32
    const-string v0, "websocket"

    iput-object v0, p0, Lio/socket/engineio/client/transports/WebSocket;->name:Ljava/lang/String;

    .line 33
    return-void
.end method

.method static synthetic access$000(Lio/socket/engineio/client/transports/WebSocket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/WebSocket;

    .line 22
    invoke-virtual {p0}, Lio/socket/engineio/client/transports/WebSocket;->onOpen()V

    return-void
.end method

.method static synthetic access$100(Lio/socket/engineio/client/transports/WebSocket;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/WebSocket;
    .param p1, "x1"    # Ljava/lang/String;

    .line 22
    invoke-virtual {p0, p1}, Lio/socket/engineio/client/transports/WebSocket;->onData(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200(Lio/socket/engineio/client/transports/WebSocket;[B)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/WebSocket;
    .param p1, "x1"    # [B

    .line 22
    invoke-virtual {p0, p1}, Lio/socket/engineio/client/transports/WebSocket;->onData([B)V

    return-void
.end method

.method static synthetic access$300(Lio/socket/engineio/client/transports/WebSocket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/WebSocket;

    .line 22
    invoke-virtual {p0}, Lio/socket/engineio/client/transports/WebSocket;->onClose()V

    return-void
.end method

.method static synthetic access$400(Lio/socket/engineio/client/transports/WebSocket;Ljava/lang/String;Ljava/lang/Exception;)Lio/socket/engineio/client/Transport;
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/WebSocket;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Ljava/lang/Exception;

    .line 22
    invoke-virtual {p0, p1, p2}, Lio/socket/engineio/client/transports/WebSocket;->onError(Ljava/lang/String;Ljava/lang/Exception;)Lio/socket/engineio/client/Transport;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$500(Lio/socket/engineio/client/transports/WebSocket;)Lokhttp3/WebSocket;
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/WebSocket;

    .line 22
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket;->ws:Lokhttp3/WebSocket;

    return-object v0
.end method

.method static synthetic access$600()Ljava/util/logging/Logger;
    .locals 1

    .line 22
    sget-object v0, Lio/socket/engineio/client/transports/WebSocket;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method


# virtual methods
.method protected doClose()V
    .locals 3

    .line 160
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket;->ws:Lokhttp3/WebSocket;

    if-eqz v0, :cond_0

    .line 161
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket;->ws:Lokhttp3/WebSocket;

    const/16 v1, 0x3e8

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Lokhttp3/WebSocket;->close(ILjava/lang/String;)Z

    .line 162
    const/4 v0, 0x0

    iput-object v0, p0, Lio/socket/engineio/client/transports/WebSocket;->ws:Lokhttp3/WebSocket;

    .line 164
    :cond_0
    return-void
.end method

.method protected doOpen()V
    .locals 8

    .line 36
    new-instance v0, Ljava/util/TreeMap;

    sget-object v1, Ljava/lang/String;->CASE_INSENSITIVE_ORDER:Ljava/util/Comparator;

    invoke-direct {v0, v1}, Ljava/util/TreeMap;-><init>(Ljava/util/Comparator;)V

    .line 37
    .local v0, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket;->extraHeaders:Ljava/util/Map;

    if-eqz v1, :cond_0

    .line 38
    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket;->extraHeaders:Ljava/util/Map;

    invoke-interface {v0, v1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 40
    :cond_0
    const-string v1, "requestHeaders"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lio/socket/engineio/client/transports/WebSocket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 42
    move-object v1, p0

    .line 43
    .local v1, "self":Lio/socket/engineio/client/transports/WebSocket;
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {p0}, Lio/socket/engineio/client/transports/WebSocket;->uri()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 44
    .local v2, "builder":Lokhttp3/Request$Builder;
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .line 45
    .local v4, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 46
    .local v6, "v":Ljava/lang/String;
    invoke-interface {v4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-virtual {v2, v7, v6}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 47
    .end local v6    # "v":Ljava/lang/String;
    goto :goto_1

    .line 48
    .end local v4    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    :cond_1
    goto :goto_0

    .line 49
    :cond_2
    invoke-virtual {v2}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v3

    .line 50
    .local v3, "request":Lokhttp3/Request;
    iget-object v4, p0, Lio/socket/engineio/client/transports/WebSocket;->webSocketFactory:Lokhttp3/WebSocket$Factory;

    new-instance v5, Lio/socket/engineio/client/transports/WebSocket$1;

    invoke-direct {v5, p0, v1}, Lio/socket/engineio/client/transports/WebSocket$1;-><init>(Lio/socket/engineio/client/transports/WebSocket;Lio/socket/engineio/client/transports/WebSocket;)V

    invoke-interface {v4, v3, v5}, Lokhttp3/WebSocket$Factory;->newWebSocket(Lokhttp3/Request;Lokhttp3/WebSocketListener;)Lokhttp3/WebSocket;

    move-result-object v4

    iput-object v4, p0, Lio/socket/engineio/client/transports/WebSocket;->ws:Lokhttp3/WebSocket;

    .line 112
    return-void
.end method

.method protected uri()Ljava/lang/String;
    .locals 8

    .line 167
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket;->query:Ljava/util/Map;

    .line 168
    .local v0, "query":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez v0, :cond_0

    .line 169
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    move-object v0, v1

    .line 171
    :cond_0
    iget-boolean v1, p0, Lio/socket/engineio/client/transports/WebSocket;->secure:Z

    const-string v2, "wss"

    const-string v3, "ws"

    if-eqz v1, :cond_1

    move-object v1, v2

    goto :goto_0

    :cond_1
    move-object v1, v3

    .line 172
    .local v1, "schema":Ljava/lang/String;
    :goto_0
    const-string v4, ""

    .line 174
    .local v4, "port":Ljava/lang/String;
    iget v5, p0, Lio/socket/engineio/client/transports/WebSocket;->port:I

    const-string v6, ":"

    if-lez v5, :cond_4

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget v2, p0, Lio/socket/engineio/client/transports/WebSocket;->port:I

    const/16 v5, 0x1bb

    if-ne v2, v5, :cond_3

    .line 175
    :cond_2
    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    iget v2, p0, Lio/socket/engineio/client/transports/WebSocket;->port:I

    const/16 v3, 0x50

    if-eq v2, v3, :cond_4

    .line 176
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lio/socket/engineio/client/transports/WebSocket;->port:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 179
    :cond_4
    iget-boolean v2, p0, Lio/socket/engineio/client/transports/WebSocket;->timestampRequests:Z

    if-eqz v2, :cond_5

    .line 180
    iget-object v2, p0, Lio/socket/engineio/client/transports/WebSocket;->timestampParam:Ljava/lang/String;

    invoke-static {}, Lio/socket/yeast/Yeast;->yeast()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 183
    :cond_5
    invoke-static {v0}, Lio/socket/parseqs/ParseQS;->encode(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v2

    .line 184
    .local v2, "derivedQuery":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_6

    .line 185
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "?"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 188
    :cond_6
    iget-object v3, p0, Lio/socket/engineio/client/transports/WebSocket;->hostname:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    .line 189
    .local v3, "ipv6":Z
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "://"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    if-eqz v3, :cond_7

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lio/socket/engineio/client/transports/WebSocket;->hostname:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_1

    :cond_7
    iget-object v6, p0, Lio/socket/engineio/client/transports/WebSocket;->hostname:Ljava/lang/String;

    :goto_1
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lio/socket/engineio/client/transports/WebSocket;->path:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    return-object v5
.end method

.method protected write([Lio/socket/engineio/parser/Packet;)V
    .locals 8
    .param p1, "packets"    # [Lio/socket/engineio/parser/Packet;

    .line 115
    move-object v0, p0

    .line 116
    .local v0, "self":Lio/socket/engineio/client/transports/WebSocket;
    const/4 v1, 0x0

    iput-boolean v1, p0, Lio/socket/engineio/client/transports/WebSocket;->writable:Z

    .line 118
    new-instance v2, Lio/socket/engineio/client/transports/WebSocket$2;

    invoke-direct {v2, p0, v0}, Lio/socket/engineio/client/transports/WebSocket$2;-><init>(Lio/socket/engineio/client/transports/WebSocket;Lio/socket/engineio/client/transports/WebSocket;)V

    .line 133
    .local v2, "done":Ljava/lang/Runnable;
    array-length v3, p1

    filled-new-array {v3}, [I

    move-result-object v3

    .line 134
    .local v3, "total":[I
    array-length v4, p1

    :goto_0
    if-ge v1, v4, :cond_1

    aget-object v5, p1, v1

    .line 135
    .local v5, "packet":Lio/socket/engineio/parser/Packet;
    iget-object v6, p0, Lio/socket/engineio/client/transports/WebSocket;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    sget-object v7, Lio/socket/engineio/client/Transport$ReadyState;->OPENING:Lio/socket/engineio/client/Transport$ReadyState;

    if-eq v6, v7, :cond_0

    iget-object v6, p0, Lio/socket/engineio/client/transports/WebSocket;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    sget-object v7, Lio/socket/engineio/client/Transport$ReadyState;->OPEN:Lio/socket/engineio/client/Transport$ReadyState;

    if-eq v6, v7, :cond_0

    .line 137
    goto :goto_1

    .line 140
    :cond_0
    new-instance v6, Lio/socket/engineio/client/transports/WebSocket$3;

    invoke-direct {v6, p0, v0, v3, v2}, Lio/socket/engineio/client/transports/WebSocket$3;-><init>(Lio/socket/engineio/client/transports/WebSocket;Lio/socket/engineio/client/transports/WebSocket;[ILjava/lang/Runnable;)V

    invoke-static {v5, v6}, Lio/socket/engineio/parser/Parser;->encodePacket(Lio/socket/engineio/parser/Packet;Lio/socket/engineio/parser/Parser$EncodeCallback;)V

    .line 134
    .end local v5    # "packet":Lio/socket/engineio/parser/Packet;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 157
    :cond_1
    :goto_1
    return-void
.end method
