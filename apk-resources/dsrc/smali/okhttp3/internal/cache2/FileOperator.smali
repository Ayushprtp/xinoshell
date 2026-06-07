.class final Lokhttp3/internal/cache2/FileOperator;
.super Ljava/lang/Object;
.source "FileOperator.java"


# instance fields
.field private final fileChannel:Ljava/nio/channels/FileChannel;


# direct methods
.method constructor <init>(Ljava/nio/channels/FileChannel;)V
    .locals 0
    .param p1, "fileChannel"    # Ljava/nio/channels/FileChannel;

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    iput-object p1, p0, Lokhttp3/internal/cache2/FileOperator;->fileChannel:Ljava/nio/channels/FileChannel;

    .line 41
    return-void
.end method


# virtual methods
.method public read(JLokio/Buffer;J)V
    .locals 9
    .param p1, "pos"    # J
    .param p3, "sink"    # Lokio/Buffer;
    .param p4, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 60
    const-wide/16 v0, 0x0

    cmp-long v2, p4, v0

    if-ltz v2, :cond_1

    move-wide v4, p1

    move-wide v6, p4

    .line 62
    .end local p1    # "pos":J
    .end local p4    # "byteCount":J
    .local v4, "pos":J
    .local v6, "byteCount":J
    :goto_0
    cmp-long p1, v6, v0

    if-lez p1, :cond_0

    .line 63
    iget-object v3, p0, Lokhttp3/internal/cache2/FileOperator;->fileChannel:Ljava/nio/channels/FileChannel;

    move-object v8, p3

    .end local p3    # "sink":Lokio/Buffer;
    .local v8, "sink":Lokio/Buffer;
    invoke-virtual/range {v3 .. v8}, Ljava/nio/channels/FileChannel;->transferTo(JJLjava/nio/channels/WritableByteChannel;)J

    move-result-wide p1

    .line 64
    .local p1, "bytesRead":J
    add-long/2addr v4, p1

    .line 65
    sub-long/2addr v6, p1

    .line 66
    .end local p1    # "bytesRead":J
    goto :goto_0

    .line 67
    .end local v8    # "sink":Lokio/Buffer;
    .restart local p3    # "sink":Lokio/Buffer;
    :cond_0
    return-void

    .line 60
    .end local v4    # "pos":J
    .end local v6    # "byteCount":J
    .local p1, "pos":J
    .restart local p4    # "byteCount":J
    :cond_1
    move-object v8, p3

    .end local p3    # "sink":Lokio/Buffer;
    .restart local v8    # "sink":Lokio/Buffer;
    new-instance p3, Ljava/lang/IndexOutOfBoundsException;

    invoke-direct {p3}, Ljava/lang/IndexOutOfBoundsException;-><init>()V

    throw p3
.end method

.method public write(JLokio/Buffer;J)V
    .locals 9
    .param p1, "pos"    # J
    .param p3, "source"    # Lokio/Buffer;
    .param p4, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 45
    const-wide/16 v0, 0x0

    cmp-long v2, p4, v0

    if-ltz v2, :cond_1

    invoke-virtual {p3}, Lokio/Buffer;->size()J

    move-result-wide v2

    cmp-long v2, p4, v2

    if-gtz v2, :cond_1

    move-wide v5, p1

    move-wide v7, p4

    .line 47
    .end local p1    # "pos":J
    .end local p4    # "byteCount":J
    .local v5, "pos":J
    .local v7, "byteCount":J
    :goto_0
    cmp-long p1, v7, v0

    if-lez p1, :cond_0

    .line 48
    iget-object v3, p0, Lokhttp3/internal/cache2/FileOperator;->fileChannel:Ljava/nio/channels/FileChannel;

    move-object v4, p3

    .end local p3    # "source":Lokio/Buffer;
    .local v4, "source":Lokio/Buffer;
    invoke-virtual/range {v3 .. v8}, Ljava/nio/channels/FileChannel;->transferFrom(Ljava/nio/channels/ReadableByteChannel;JJ)J

    move-result-wide p1

    .line 49
    .local p1, "bytesWritten":J
    add-long/2addr v5, p1

    .line 50
    sub-long/2addr v7, p1

    .line 51
    .end local p1    # "bytesWritten":J
    goto :goto_0

    .line 52
    .end local v4    # "source":Lokio/Buffer;
    .restart local p3    # "source":Lokio/Buffer;
    :cond_0
    return-void

    .line 45
    .end local v5    # "pos":J
    .end local v7    # "byteCount":J
    .local p1, "pos":J
    .restart local p4    # "byteCount":J
    :cond_1
    move-object v4, p3

    .end local p3    # "source":Lokio/Buffer;
    .restart local v4    # "source":Lokio/Buffer;
    new-instance p3, Ljava/lang/IndexOutOfBoundsException;

    invoke-direct {p3}, Ljava/lang/IndexOutOfBoundsException;-><init>()V

    throw p3
.end method
