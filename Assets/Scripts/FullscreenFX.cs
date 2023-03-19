using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(FullscreenFXRenderer), PostProcessEvent.BeforeStack, "L3/PostProcess")]
public sealed class FullscreenFX : PostProcessEffectSettings
{
    public FloatParameter radius = new FloatParameter { value = 1 };
    public FloatParameter amount = new FloatParameter { value = 1 };
    public FloatParameter saturation = new FloatParameter { value = 1 };
    public FloatParameter tint = new FloatParameter { value = 1 };
}

public sealed class FullscreenFXRenderer : PostProcessEffectRenderer<FullscreenFX>
{
    public override void Render(PostProcessRenderContext context)
    {
        var sheet = context.propertySheets.Get(Shader.Find("L3/PostProcess"));
        sheet.properties.SetFloat("_Radius", settings.radius * 0.01f);
        sheet.properties.SetFloat("_Amount", settings.amount);
        sheet.properties.SetFloat("_Saturation", settings.saturation);
        sheet.properties.SetFloat("_Tint", settings.tint);
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}