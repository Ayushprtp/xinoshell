.class Lcom/google/xinoshell/utils/callForwardingUtility$1;
.super Landroid/telephony/TelephonyManager$UssdResponseCallback;
.source "callForwardingUtility.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/utils/callForwardingUtility;->executeUSSD(Ljava/lang/String;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/utils/callForwardingUtility;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/utils/callForwardingUtility;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/utils/callForwardingUtility;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 67
    iput-object p1, p0, Lcom/google/xinoshell/utils/callForwardingUtility$1;->this$0:Lcom/google/xinoshell/utils/callForwardingUtility;

    invoke-direct {p0}, Landroid/telephony/TelephonyManager$UssdResponseCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceiveUssdResponse(Landroid/telephony/TelephonyManager;Ljava/lang/String;Ljava/lang/CharSequence;)V
    .locals 2
    .param p1, "telephonyManager"    # Landroid/telephony/TelephonyManager;
    .param p2, "request"    # Ljava/lang/String;
    .param p3, "response"    # Ljava/lang/CharSequence;

    .line 70
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "USSD Response: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CallForwardingUtility"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    return-void
.end method

.method public onReceiveUssdResponseFailed(Landroid/telephony/TelephonyManager;Ljava/lang/String;I)V
    .locals 2
    .param p1, "telephonyManager"    # Landroid/telephony/TelephonyManager;
    .param p2, "request"    # Ljava/lang/String;
    .param p3, "failureCode"    # I

    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "USSD Request Failed! Code: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CallForwardingUtility"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 76
    return-void
.end method
