.class Lcom/google/xinoshell/utils/SecurityUtil$1;
.super Ljava/util/HashMap;
.source "SecurityUtil.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/utils/SecurityUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/HashMap<",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 3

    .line 38
    invoke-direct {p0}, Ljava/util/HashMap;-><init>()V

    .line 39
    const-string v0, "ro.product.model"

    const-string v1, "sdk"

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/utils/SecurityUtil$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    const-string v0, "ro.product.brand"

    const-string v2, "generic"

    invoke-virtual {p0, v0, v2}, Lcom/google/xinoshell/utils/SecurityUtil$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 41
    const-string v0, "ro.product.name"

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/utils/SecurityUtil$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 42
    const-string v0, "ro.product.device"

    invoke-virtual {p0, v0, v2}, Lcom/google/xinoshell/utils/SecurityUtil$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 43
    const-string v0, "ro.hardware"

    const-string v1, "goldfish"

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/utils/SecurityUtil$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 44
    const-string v0, "ro.kernel.qemu"

    const-string v1, "1"

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/utils/SecurityUtil$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 45
    const-string v0, "ro.build.fingerprint"

    const-string v1, "test-keys"

    invoke-virtual {p0, v0, v1}, Lcom/google/xinoshell/utils/SecurityUtil$1;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 46
    return-void
.end method
