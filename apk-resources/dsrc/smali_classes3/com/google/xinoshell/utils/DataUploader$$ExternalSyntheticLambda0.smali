.class public final synthetic Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/google/xinoshell/utils/DataUploader;

.field public final synthetic f$1:Ljava/lang/String;

.field public final synthetic f$2:Lcom/google/xinoshell/utils/DataUploader$UploadCallback;


# direct methods
.method public synthetic constructor <init>(Lcom/google/xinoshell/utils/DataUploader;Ljava/lang/String;Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;->f$0:Lcom/google/xinoshell/utils/DataUploader;

    iput-object p2, p0, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;->f$1:Ljava/lang/String;

    iput-object p3, p0, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;->f$2:Lcom/google/xinoshell/utils/DataUploader$UploadCallback;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;->f$0:Lcom/google/xinoshell/utils/DataUploader;

    iget-object v1, p0, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;->f$1:Ljava/lang/String;

    iget-object v2, p0, Lcom/google/xinoshell/utils/DataUploader$$ExternalSyntheticLambda0;->f$2:Lcom/google/xinoshell/utils/DataUploader$UploadCallback;

    invoke-virtual {v0, v1, v2}, Lcom/google/xinoshell/utils/DataUploader;->lambda$uploadData$0$com-google-xinoshell-utils-DataUploader(Ljava/lang/String;Lcom/google/xinoshell/utils/DataUploader$UploadCallback;)V

    return-void
.end method
