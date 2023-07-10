/**
 * Request to do nothing.
 */
class EmptyRequest extends ElementRequest<String> {
  /**
   * @override
   */
  public String getData() {
    return "";
  }
}
