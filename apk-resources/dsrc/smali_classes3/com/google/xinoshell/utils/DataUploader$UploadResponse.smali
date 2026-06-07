.class public Lcom/google/xinoshell/utils/DataUploader$UploadResponse;
.super Ljava/lang/Object;
.source "DataUploader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/utils/DataUploader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "UploadResponse"
.end annotation


# instance fields
.field public final filename:Ljava/lang/String;

.field public final mimetype:Ljava/lang/String;

.field public final path:Ljava/lang/String;

.field public final size:J

.field public final success:Z


# direct methods
.method public constructor <init>(ZLjava/lang/String;Ljava/lang/String;JLjava/lang/String;)V
    .locals 0
    .param p1, "success"    # Z
    .param p2, "filename"    # Ljava/lang/String;
    .param p3, "path"    # Ljava/lang/String;
    .param p4, "size"    # J
    .param p6, "mimetype"    # Ljava/lang/String;

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    iput-boolean p1, p0, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;->success:Z

    .line 35
    iput-object p2, p0, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;->filename:Ljava/lang/String;

    .line 36
    iput-object p3, p0, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;->path:Ljava/lang/String;

    .line 37
    iput-wide p4, p0, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;->size:J

    .line 38
    iput-object p6, p0, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;->mimetype:Ljava/lang/String;

    .line 39
    return-void
.end method


# virtual methods
.method public getPath()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/google/xinoshell/utils/DataUploader$UploadResponse;->path:Ljava/lang/String;

    return-object v0
.end method
