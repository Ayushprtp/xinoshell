.class public final Landroidx/core/view/inputmethod/EditorInfoCompat;
.super Ljava/lang/Object;
.source "EditorInfoCompat.java"


# static fields
.field private static final CONTENT_MIME_TYPES_INTEROP_KEY:Ljava/lang/String; = "android.support.v13.view.inputmethod.EditorInfoCompat.CONTENT_MIME_TYPES"

.field private static final CONTENT_MIME_TYPES_KEY:Ljava/lang/String; = "androidx.core.view.inputmethod.EditorInfoCompat.CONTENT_MIME_TYPES"

.field private static final EMPTY_STRING_ARRAY:[Ljava/lang/String;

.field public static final IME_FLAG_FORCE_ASCII:I = -0x80000000

.field public static final IME_FLAG_NO_PERSONALIZED_LEARNING:I = 0x1000000


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 76
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Landroidx/core/view/inputmethod/EditorInfoCompat;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 182
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 183
    return-void
.end method

.method public static getContentMimeTypes(Landroid/view/inputmethod/EditorInfo;)[Ljava/lang/String;
    .locals 2
    .param p0, "editorInfo"    # Landroid/view/inputmethod/EditorInfo;

    .line 135
    nop

    .line 136
    iget-object v0, p0, Landroid/view/inputmethod/EditorInfo;->contentMimeTypes:[Ljava/lang/String;

    .line 137
    .local v0, "result":[Ljava/lang/String;
    if-eqz v0, :cond_0

    move-object v1, v0

    goto :goto_0

    :cond_0
    sget-object v1, Landroidx/core/view/inputmethod/EditorInfoCompat;->EMPTY_STRING_ARRAY:[Ljava/lang/String;

    :goto_0
    return-object v1
.end method

.method static getProtocol(Landroid/view/inputmethod/EditorInfo;)I
    .locals 1
    .param p0, "editorInfo"    # Landroid/view/inputmethod/EditorInfo;

    .line 159
    nop

    .line 160
    const/4 v0, 0x1

    return v0
.end method

.method public static setContentMimeTypes(Landroid/view/inputmethod/EditorInfo;[Ljava/lang/String;)V
    .locals 0
    .param p0, "editorInfo"    # Landroid/view/inputmethod/EditorInfo;
    .param p1, "contentMimeTypes"    # [Ljava/lang/String;

    .line 112
    nop

    .line 113
    iput-object p1, p0, Landroid/view/inputmethod/EditorInfo;->contentMimeTypes:[Ljava/lang/String;

    .line 121
    return-void
.end method
