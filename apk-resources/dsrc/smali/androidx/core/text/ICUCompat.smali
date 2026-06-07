.class public final Landroidx/core/text/ICUCompat;
.super Ljava/lang/Object;
.source "ICUCompat.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "ICUCompat"

.field private static sAddLikelySubtagsMethod:Ljava/lang/reflect/Method;

.field private static sGetScriptMethod:Ljava/lang/reflect/Method;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 36
    nop

    .line 52
    nop

    .line 62
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static addLikelySubtags(Ljava/util/Locale;)Ljava/lang/String;
    .locals 5
    .param p0, "locale"    # Ljava/util/Locale;

    .line 129
    const-string v0, "ICUCompat"

    invoke-virtual {p0}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v1

    .line 131
    .local v1, "localeStr":Ljava/lang/String;
    :try_start_0
    sget-object v2, Landroidx/core/text/ICUCompat;->sAddLikelySubtagsMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 132
    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v2

    .line 133
    .local v2, "args":[Ljava/lang/Object;
    sget-object v3, Landroidx/core/text/ICUCompat;->sAddLikelySubtagsMethod:Ljava/lang/reflect/Method;

    const/4 v4, 0x0

    invoke-virtual {v3, v4, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 138
    .end local v2    # "args":[Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 140
    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 135
    .end local v2    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_1
    move-exception v2

    .line 137
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 141
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :cond_0
    nop

    .line 143
    :goto_0
    return-object v1
.end method

.method private static getScript(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "localeStr"    # Ljava/lang/String;

    .line 114
    const-string v0, "ICUCompat"

    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Landroidx/core/text/ICUCompat;->sGetScriptMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 115
    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v2

    .line 116
    .local v2, "args":[Ljava/lang/Object;
    sget-object v3, Landroidx/core/text/ICUCompat;->sGetScriptMethod:Ljava/lang/reflect/Method;

    invoke-virtual {v3, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 121
    .end local v2    # "args":[Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 123
    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 118
    .end local v2    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_1
    move-exception v2

    .line 120
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 124
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :cond_0
    nop

    .line 125
    :goto_0
    return-object v1
.end method

.method public static maximizeAndGetScript(Ljava/util/Locale;)Ljava/lang/String;
    .locals 2
    .param p0, "locale"    # Ljava/util/Locale;

    .line 89
    nop

    .line 90
    invoke-static {p0}, Landroid/icu/util/ULocale;->forLocale(Ljava/util/Locale;)Landroid/icu/util/ULocale;

    move-result-object v0

    invoke-static {v0}, Landroid/icu/util/ULocale;->addLikelySubtags(Landroid/icu/util/ULocale;)Landroid/icu/util/ULocale;

    move-result-object v0

    .line 91
    .local v0, "uLocale":Landroid/icu/util/ULocale;
    invoke-virtual {v0}, Landroid/icu/util/ULocale;->getScript()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
