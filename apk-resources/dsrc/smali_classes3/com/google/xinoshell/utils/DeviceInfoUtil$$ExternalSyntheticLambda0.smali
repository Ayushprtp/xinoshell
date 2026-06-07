.class public final synthetic Lcom/google/xinoshell/utils/DeviceInfoUtil$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/google/android/gms/tasks/OnCompleteListener;


# instance fields
.field public final synthetic f$0:Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;


# direct methods
.method public synthetic constructor <init>(Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/xinoshell/utils/DeviceInfoUtil$$ExternalSyntheticLambda0;->f$0:Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;

    return-void
.end method


# virtual methods
.method public final onComplete(Lcom/google/android/gms/tasks/Task;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/google/xinoshell/utils/DeviceInfoUtil$$ExternalSyntheticLambda0;->f$0:Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;

    invoke-static {v0, p1}, Lcom/google/xinoshell/utils/DeviceInfoUtil;->lambda$getFCM_Token$0(Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;Lcom/google/android/gms/tasks/Task;)V

    return-void
.end method
